import Foundation

enum GameString: String {

    case start = "game_start"
    case win = "game_win"
    case match = "game_match"
    case tapCard = "game_tap_card"

    var localized: String {
        return NSLocalizedString(rawValue, tableName: "GameLocalized", comment: "")
    }

}
