import XCTest
@testable import Memory

final class GameViewTests: XCTestCase {

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
