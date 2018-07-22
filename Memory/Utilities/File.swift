//
//  File.swift
//  Memory Game
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
