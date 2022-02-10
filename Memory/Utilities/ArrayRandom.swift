import Foundation
import GameKit

// MARK: - Extension to shuffle Arrays
extension Array {

    /// Mutate array by a random shuffle using GameKit.
    ///
    /// - Parameter seed: start point for pseudorandom.
    mutating func shuffled(seed: UInt64? = nil) {
        if let seed = seed,
            let array = GKMersenneTwisterRandomSource(seed: seed).arrayByShufflingObjects(in: self) as? Array {
            self = array
        } else if let array = GKMersenneTwisterRandomSource().arrayByShufflingObjects(in: self) as? Array {
            self = array
        }
    }
}
