//
//  GameInteractor.swift
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

class GameInteractor: GameInteractorInputProtocol {

    weak var presenter: GameInteractorOutputProtocol?
    var localDatamanager: GameLocalDataManagerInputProtocol?
    init() {}

    private var matchedCards = [Card]()
    private var shownCards = [Card]()
    private var cardsAmount = 0

}

// MARK: - Game life cycle
extension GameInteractor {

    func startGame(cardsAmount: Int) throws {
        guard let localDatamanager = localDatamanager else { return }
        self.cardsAmount = cardsAmount
        let content = try localDatamanager.fetchContent(amount: cardsAmount/2)
        let deck = createDeck(from: content)
        presenter?.gameDidStart(with: deck)
    }

    func checkGameStatus() {
        if matchedCards.count == cardsAmount {
            presenter?.gameDidFinish()
            resetGame()
        } else {
            presenter?.match()
        }
    }

    func resetGame() {
        matchedCards.removeAll()
        shownCards.removeAll()
    }

}

// MARK: - Memory Game Game Logic
extension GameInteractor {

    func didSelect(card: Card) {

        guard let unpaired = unpairedCard() else {
            // There are not enoght showed cards.
            shownCards.append(card)
            return
        }

        guard card.isMatch(of: unpaired) else {
            // Is not a match.
            isNotMatch(of: [card, unpaired])
            return
        }

        // Is a match!
        isMatch(of: [card, unpaired])
    }

    private func isNotMatch(of cards: [Card]) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.presenter?.hide(cards: cards)
        }
    }

    private func isMatch(of cards: [Card]) {
        matchedCards.append(contentsOf: cards)
        checkGameStatus()
    }

    private func unpairedCard() -> Card? {
        guard shownCards.count > 0 else { return nil }
        return shownCards.removeLast()
    }

}

// MARK: - Random Generator
extension GameInteractor {

    func createDeck(from content: [Content], seed: UInt64? = nil) -> [Card] {
        var deck = [Card]()

        for cont in content {
            let card = Card(content: cont)
            deck.append(contentsOf: [card, card.getCopy()]) // create card, and a pair.
        }

        deck.shuffled(seed: seed)
        return deck
    }

}
