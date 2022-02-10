import XCTest
@testable import Memory

final class FileTests: XCTestCase {

    func testSuccess() {

        do {
            let json = try File.getContent(from: "content")
            XCTAssert(json.count > 0, "")
        } catch {
            XCTFail("Error opening content files")
        }
    }

    func testNoFile() {
        do {
            _ = try File.getContent(from: "späti")
            XCTFail("Error opening a file that doesn´t exist in the bundle.")
        } catch {
            XCTAssert((error as? FileError) == .nofile, "Showing wrong error")
        }
    }

    func testFileCorruption() {
        do {
            _ = try File.getContent(from: "corruptsample", bundle: Bundle(for: FileTests.self))
            XCTFail("Error opening a file that doesn´t exist in the bundle.")
        } catch {
            XCTAssert((error as? FileError) == .formatCorrupt, "Showing wrong error")
        }
    }

}
