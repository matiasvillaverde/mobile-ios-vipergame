import Foundation

final class GameLocalDataManager: GameLocalDataManagerInputProtocol {

    init() {}

    /// Synchronically search for content.
    ///
    /// - Returns: Array with Players
    /// - Throws: can fail and throw a Fetch error.
    func fetchContent(amount: Int) throws -> [Content] {

        return try loadExample(amount: amount)

    }

    func loadExample(amount: Int) throws -> [Content] {

        // Search for json sample.
        let json = try File.getContent(from: "content")

        var output = [Content]()

        // Iterates the array
        json.forEach { contentJson in

            guard output.count < amount else { return }

            let content = map(json: contentJson)
            output.append(content)

        }

        return output
    }

    func map(json: NSDictionary) -> Logo {

        let keyImage = "image"
        let keyDescription = "description"

        guard
            let image = json[keyImage] as? String,
            let description = json[keyDescription] as? String
            else { fatalError("Developer: Wrong format of content.") }

        return Logo(name: image.capitalized, description: description, image: image)

    }

}
