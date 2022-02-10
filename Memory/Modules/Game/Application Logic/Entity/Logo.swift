import Foundation

/// Implementation of Content to be Tech Logos.
struct Logo: Content {

    var name: String
    var description: String
    var imageURL: URL

    func displayName() -> String {
        return "\(name.capitalized)"
    }

}
