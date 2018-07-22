//
//  CardTests.swift
//  Memory GameTests
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

class CardTests: XCTestCase {

    let url = URL(string: "https://amp.businessinsider.com/images/5b2d2faa1ae66235008b4705-750-563.jpg")!
    lazy var content = Logo(name: "swift",
                            description: "programming language",
                            imageURL: URL(string: "http://www.matiasvillaverde.com/mobile-ios-vipergame/swift.png")!)

    func test_Initialization() {
        let card = Card(content: content)
        XCTAssertNotNil(card)
        XCTAssertEqual(card.content.imageURL, content.imageURL)
        XCTAssertTrue(!card.shown)
    }

    func test_Initialization_Copy() {
        let card = Card(content: content)
        let copy = card.getCopy()
        XCTAssertEqual(card.content.imageURL, copy.content.imageURL)
        XCTAssertNotEqual(card, copy) // Same Image but different ID
        XCTAssertTrue(card.isMatch(of: card))
    }

}
