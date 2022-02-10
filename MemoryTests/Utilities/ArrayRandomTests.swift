import XCTest
@testable import Memory

final class ArrayRandomTests: XCTestCase {

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
