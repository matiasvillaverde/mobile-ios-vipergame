import Foundation

/// Model to reprecent a Memory Game card.
struct Card {

    /// Create a Card with a specific image.
    ///
    /// - Parameter content: Content of the card, can be a football player, a music track, etc.
    init(content: Content) {
        self.identifier = UUID()
        self.content = content
    }

    var identifier: UUID
    var content: Content
    var shown = false

}

// MARK: - Actions.
extension Card {

    func getCopy() -> Card {
        return Card(content: content)
    }

    func isMatch(of card: Card) -> Bool {
        return card.content.image == content.image
    }

}

// MARK: - Equatable
extension Card: Equatable {

    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }

}
