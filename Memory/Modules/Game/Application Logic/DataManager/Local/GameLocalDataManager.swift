//
//  GameLocalDataManager.swift
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

class GameLocalDataManager: GameLocalDataManagerInputProtocol {

    init() {}

    /// Synchronically search for content.
    ///
    /// - Returns: Array with Players
    /// - Throws: can fail and throw a Fetch error.
    func fetchContent(amount: Int) throws -> [Content] {

        return try loadExample(amount: amount)

    }

}

// MARK: - Load Teck Logos example from JSON in disk. This can be replaced for any content source.
extension GameLocalDataManager {

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
        let keyImageURL = "http://matiasvillaverde.com/mobile-ios-vipergame/"
        let keyImageURLExtension = ".png"
        let keyDescription = "description"

        guard
            let image = json[keyImage] as? String,
            let imageURL = URL(string: keyImageURL + image + keyImageURLExtension),
            let description = json[keyDescription] as? String
            else { fatalError("Developer: Wrong format of content.") }

        return Logo(name: image.capitalized, description: description, imageURL: imageURL)

    }

}
