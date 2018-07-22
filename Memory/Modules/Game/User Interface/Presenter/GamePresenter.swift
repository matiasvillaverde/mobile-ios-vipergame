//
//  GamePresenter.swift
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

class GamePresenter: GamePresenterProtocol, GameInteractorOutputProtocol {

    weak var view: GameViewProtocol?
    var interactor: GameInteractorInputProtocol?
    var wireFrame: GameWireFrameProtocol?

    init() {}

    private var deck = [Card]()
    private let vibrator = Vibrator()
}

// MARK: - Game life cycle.
extension GamePresenter {

    func startGame() {
        view?.show(content: GameString.tapCard.localized)
        do {
            try interactor?.startGame(cardsAmount: amountOfCards())
            view?.show(message: GameString.start.localized)
        } catch {
            show(error: error)
        }
    }

    func gameDidStart(with deck: [Card]) {
        self.deck = deck
        view?.reloadCollection()
    }

    func gameDidFinish() {
        deck.removeAll()
        view?.show(message: GameString.win.localized)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.startGame()
        }
    }

    func match() {
        view?.show(message: GameString.match.localized)
        vibrator.success()
    }

}

// MARK: - Output actions.
extension GamePresenter {

    func didSelect(card: Card) {
        view?.show(cards: [card])
        view?.show(content: card.content.displayName())
        interactor?.didSelect(card: card)
    }

    func show(cards: [Card]) {
        view?.show(cards: cards)
    }

    func hide(cards: [Card]) {
        view?.hide(cards: cards)
        vibrator.negation()
        view?.show(content: GameString.tapCard.localized)
    }

    func show(error: Error) {
        view?.show(error: error, completion: nil)
    }

}

// MARK: - Data.
extension GamePresenter {

    func card(at index: Int) -> Card? {
        guard deck.count > index && index >= 0 else { return nil }
        return deck[index]
    }

    func index(for card: Card) -> Int? {
        return deck.index(of: card)
    }

    func amountOfCards() -> Int {
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            return 24
        case .pad:
            return 48
        default:
            return -1
        }
    }

}
