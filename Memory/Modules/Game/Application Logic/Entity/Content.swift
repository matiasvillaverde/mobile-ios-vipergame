import Foundation

/// Content of a Memory Game card.
protocol Content {

    var name: String { get set }
    var description: String { get set }
    var image: String { get set }

    func displayName() -> String

}
