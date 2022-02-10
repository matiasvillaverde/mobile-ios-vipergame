import Foundation

final class GameInteractor: GameInteractorInputProtocol {

    weak var presenter: GameInteractorOutputProtocol?
    var localDatamanager: GameLocalDataManagerInputProtocol?
    init() {}

    private var matchedCards = [Card]()
    private var shownCards = [Card]()
    private var cardsAmount = 0

    // MARK: - Game life cycle

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

    // MARK: - Memory Game Game Logic
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
