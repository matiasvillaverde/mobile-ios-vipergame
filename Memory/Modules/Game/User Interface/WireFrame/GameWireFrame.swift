import Foundation
import UIKit

final class GameWireFrame: GameWireFrameProtocol {

    class func presentGameModule(in window: UIWindow) {

        // Generating module components
        let view = GameViewController.instance()
        let presenter: GamePresenterProtocol & GameInteractorOutputProtocol = GamePresenter()
        let interactor: GameInteractorInputProtocol = GameInteractor()
        let localDataManager: GameLocalDataManagerInputProtocol = GameLocalDataManager()
        let wireFrame: GameWireFrameProtocol = GameWireFrame()

        // Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.localDatamanager = localDataManager

        // Present UI
        window.rootViewController = view
    }

}
