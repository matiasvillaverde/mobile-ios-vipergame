//
//  GameViewProtocol.swift
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

import Foundation
import UIKit

protocol GameViewProtocol: class {

    var presenter: GamePresenterProtocol? { get set }

    // Add here your methods for communication PRESENTER -> VIEW
    func reloadCollection()
    func show(content: String)
    func show(message: String)
    func show(error: Error, completion: (() -> Swift.Void)?)
    func show(cards: [Card])
    func hide(cards: [Card])

}

protocol GameWireFrameProtocol: class {

    static func presentGameModule(in window: UIWindow)
    // Add here your methods for communication PRESENTER -> WIREFRAME

}

protocol GamePresenterProtocol: class {

    var view: GameViewProtocol? { get set }
    var interactor: GameInteractorInputProtocol? { get set }
    var wireFrame: GameWireFrameProtocol? { get set }

    // Add here your methods for communication VIEW -> PRESENTER
    func startGame()
    func index(for card: Card) -> Int?
    func card(at index: Int) -> Card?
    func didSelect(card: Card)
    func amountOfCards() -> Int

}

protocol GameInteractorOutputProtocol: class {

    // Add here your methods for communication INTERACTOR -> PRESENTER
    func gameDidStart(with deck: [Card])
    func gameDidFinish()
    func match()
    func show(cards: [Card])
    func hide(cards: [Card])
    func show(error: Error)

}

protocol GameInteractorInputProtocol: class {

    var presenter: GameInteractorOutputProtocol? { get set }
    var localDatamanager: GameLocalDataManagerInputProtocol? { get set }

    // Add here your methods for communication PRESENTER -> INTERACTOR
    func startGame(cardsAmount: Int) throws
    func didSelect(card: Card)

}

protocol GameLocalDataManagerInputProtocol: class {

    // Add here your methods for communication INTERACTOR -> LOCALDATAMANAGER
    func fetchContent(amount: Int) throws -> [Content]

}
