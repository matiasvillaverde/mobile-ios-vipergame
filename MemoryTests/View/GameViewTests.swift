//
//  GameViewTests.swift
//  Memory Game
//
//  Copyright (c) 2018 Matias Villaverde (http://matiasvillaverde.com/)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import XCTest
@testable import Memory

class GameViewTests: XCTestCase {

    /// System under test
    var sut: GameViewController!

    override func setUp() {
        super.setUp()

        sut = GameViewController.instance()
        sut.presenter = MockPresenter()

        let view = sut.view // To call viewDidLoad
        XCTAssertNotNil(view)
    }

    func testInit_SubViews() {
        XCTAssertNotNil(sut.collectionView)
        XCTAssertNotNil(sut.messageLabel)
    }

    func testInit_DelegateAndDataSource() {
        XCTAssertNotNil(sut.collectionView.delegate)
        XCTAssertNotNil(sut.collectionView.dataSource)
    }

    func test_showError() {
        sut.show(error: TestError.test) {
            XCTAssertNotNil(self.sut.presentedViewController)
            XCTAssertTrue(self.sut.presentedViewController is UIAlertController)
            XCTAssertTrue((self.sut.presentedViewController as? UIAlertController)?.actions.count == 1)
        }
    }

    func test_showHideCards() {

        guard let card = sut.presenter?.card(at: 1) else {
            XCTFail()
            return
        }

        XCTAssertFalse(card.shown)
        sut.show(cards: [card])
        sut.hide(cards: [card])
        XCTAssertFalse(card.shown)
    }

}

// MARK: - Mocks
extension GameViewTests {

    class MockPresenter: GamePresenterProtocol {

        var view: GameViewProtocol?
        let card = Card(content: content)

        var interactor: GameInteractorInputProtocol?

        var wireFrame: GameWireFrameProtocol?

        func startGame() { }

        func index(for card: Card) -> Int? {
            return 1
        }

        func card(at index: Int) -> Card? {
            return card
        }

        func didSelect(card: Card) { }

        func amountOfCards() -> Int {
            return 2
        }
    }
}
