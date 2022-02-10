import XCTest
@testable import Memory

final class CardCellTests: XCTestCase {

    var card: Card!
    var cell: CardCell!

    override func setUp() {
        super.setUp()
        card = Card(content: content)
        cell = CardCell(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    }

    func test_SetCard() {
        cell.card = card
        XCTAssertNotNil(cell.card)
        cell.card = nil
        XCTAssertNil(cell.card)
    }

    func test_Show() {

        // Initial
        XCTAssertFalse(cell.shown)

        // Show with animations
        show(animated: true)
        show(animated: false)
    }

    // MARK: - Usefull methods
    func show(animated: Bool) {
        // Show
        cell.show(animated: animated)
        XCTAssertTrue(cell.shown)

        // Hide
        cell.show(animated: animated)
        XCTAssertFalse(cell.shown)
    }

}
