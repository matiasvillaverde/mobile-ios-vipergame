import Foundation
import UIKit

final class GamePresenter: GamePresenterProtocol, GameInteractorOutputProtocol {

    weak var view: GameViewProtocol?
    var interactor: GameInteractorInputProtocol?
    var wireFrame: GameWireFrameProtocol?

    init() {}

    private var deck = [Card]()
    private let vibrator = Vibrator()

    // MARK: - Game life cycle.

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

    // MARK: - Output actions.

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
