//
//  FileUtilityTests.swift
//  FileUtilityTests
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

import XCTest
@testable import Memory

class FileTests: XCTestCase {

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
