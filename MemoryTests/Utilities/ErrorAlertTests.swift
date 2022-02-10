import XCTest
@testable import Memory

enum TestError: Error {
    case test
}

final class ErrorAlertTests: XCTestCase {

    func test_ShowError() {

        let viewControler = UIViewController()
        _ = viewControler.view // To call viewDidload
        let error = TestError.test

        viewControler.present(error: error, animated: true, completion: {
            XCTAssertNotNil(viewControler.presentedViewController)
            XCTAssertTrue(viewControler.presentedViewController is UIAlertController)
            XCTAssertTrue((viewControler.presentedViewController as? UIAlertController)?.actions.count == 1)
        })

    }

}
