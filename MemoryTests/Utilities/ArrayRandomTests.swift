//
//  ArrayRandomTests.swift
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

class ArrayRandomTests: XCTestCase {

    /// System under test: Array suffled.
    var sut: [Card]!

    override func setUp() {
        super.setUp()

        sut = [Card]()
        for _ in 1...1000 {
            sut.append(Card(content: content))
        }
    }

    func test_Random() {

        let cardsOriginalOrder: [Card]! = sut
        sut.shuffled()

        XCTAssertNotEqual(sut, cardsOriginalOrder)
    }

    func test_RandomWithSeed() {

        let seed: UInt64 = 1000

        // Shuffle
        var cardsOriginalOrder: [Card]! = sut
        sut.shuffled(seed: seed)

        // Shuffle second time
        let cardsShuffledOrder: [Card]! = sut
        cardsOriginalOrder.shuffled(seed: seed)

        XCTAssertEqual(sut, cardsShuffledOrder)
    }

}
