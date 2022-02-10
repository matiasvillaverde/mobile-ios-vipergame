import XCTest
@testable import Memory

final class CardTests: XCTestCase {

    let url = "swift"
    lazy var content = Logo(name: "swift",
                            description: "programming language",
                            image: "swift")

    func test_Initialization() {
        let card = Card(content: content)
        XCTAssertNotNil(card)
        XCTAssertEqual(card.content.image, content.image)
        XCTAssertTrue(!card.shown)
    }

    func test_Initialization_Copy() {
        let card = Card(content: content)
        let copy = card.getCopy()
        XCTAssertEqual(card.content.image, copy.content.image)
        XCTAssertNotEqual(card, copy) // Same Image but different ID
        XCTAssertTrue(card.isMatch(of: card))
    }

}
