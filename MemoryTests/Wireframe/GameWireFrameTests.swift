import XCTest
@testable import Memory

final class GameWireFrameTests: XCTestCase {

    func test_Initialization() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        GameWireFrame.presentGameModule(in: window)

        XCTAssertNotNil(window.rootViewController)
        XCTAssertNotNil((window.rootViewController as? GameViewProtocol)?.presenter)
        XCTAssertNotNil((window.rootViewController as? GameViewProtocol)?.presenter?.interactor)
        XCTAssertNotNil((window.rootViewController as? GameViewProtocol)?.presenter?.interactor?.localDatamanager)
        XCTAssertTrue(window.rootViewController is GameViewController)
        XCTAssertTrue(window.rootViewController is GameViewProtocol)
    }

}
