import XCTest
@testable import Memory

final class CardTests: XCTestCase {

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
