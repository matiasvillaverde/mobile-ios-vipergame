import Foundation
import AudioToolbox

/// Vibration generator.
struct Vibrator {

    /// Actuate `Nope` feedback (series of three weak booms).
    func negation() {
        AudioServicesPlaySystemSound(1521)
    }

    /// Actuate `Pop` feedback (strong boom).
    func success() {
        AudioServicesPlaySystemSound(1520)
    }

}
