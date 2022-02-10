import Foundation

/// Errors that can ocurre while opening file.
///
/// - nofile: The file was not found on the bundle.
/// - formatCorrupt: The file is somehow with a wrong structure.
/// - jsonSerialization: Was not possible to serialize json.
enum FileError: Error {
    case nofile
    case formatCorrupt
}

/// Utility to search for content in a json file.
struct File {

    /// Get content from a json file.
    ///
    /// - Parameters:
    ///   - file: Name of the json file.
    ///   - bundle: bundle where to search file.
    /// - Returns: array with card content in NSDictionaries
    /// - Throws: Opening files can fail for multiple reasons. More information read FileUtilityError.
    static func getContent(from file: String, bundle: Bundle = Bundle.main) throws -> [NSDictionary] {

        guard let file = bundle.path(forResource: file, ofType: "json") else {
            throw FileError.nofile
        }

        let data = try Data(contentsOf: URL(fileURLWithPath: file))
        let dic = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary

        guard let teams = dic?["content"] as? [NSDictionary] else {
            throw FileError.formatCorrupt
        }

        return teams
    }
}
