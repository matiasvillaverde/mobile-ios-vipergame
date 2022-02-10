import Foundation
import UIKit

// Add here your methods for communication PRESENTER -> VIEW
protocol GameViewProtocol: class {

    var presenter: GamePresenterProtocol? { get set }

    func reloadCollection()
    func show(content: String)
    func show(message: String)
    func show(error: Error, completion: (() -> Swift.Void)?)
    func show(cards: [Card])
    func hide(cards: [Card])

}

// Add here your methods for communication PRESENTER -> WIREFRAME (or Router)
protocol GameWireFrameProtocol: class {

    static func presentGameModule(in window: UIWindow)
}

// Add here your methods for communication VIEW -> PRESENTER
protocol GamePresenterProtocol: class {

    var view: GameViewProtocol? { get set }
    var interactor: GameInteractorInputProtocol? { get set }
    var wireFrame: GameWireFrameProtocol? { get set }

    func startGame()
    func index(for card: Card) -> Int?
    func card(at index: Int) -> Card?
    func didSelect(card: Card)
    func amountOfCards() -> Int

}

// Add here your methods for communication INTERACTOR -> PRESENTER
protocol GameInteractorOutputProtocol: class {

    func gameDidStart(with deck: [Card])
    func gameDidFinish()
    func match()
    func show(cards: [Card])
    func hide(cards: [Card])
    func show(error: Error)

}

// Add here your methods for communication PRESENTER -> INTERACTOR
protocol GameInteractorInputProtocol: class {

    var presenter: GameInteractorOutputProtocol? { get set }
    var localDatamanager: GameLocalDataManagerInputProtocol? { get set }

    func startGame(cardsAmount: Int) throws
    func didSelect(card: Card)

}

// Add here your methods for communication INTERACTOR -> LOCALDATAMANAGER
protocol GameLocalDataManagerInputProtocol: class {
    func fetchContent(amount: Int) throws -> [Content]
}
