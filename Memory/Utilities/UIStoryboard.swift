import UIKit

// MARK: - Storyboards.
extension UIViewController {

    /// Create a UIViewController.
    ///  More information: https://medium.cobeisfresh.com/a-case-for-using-storyboards-on-ios-3bbe69efbdf4
    /// - Returns: UIViewController with a storyboard with the same name.
    class func instance() -> Self {
        let storyboardName = String(describing: self)
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
        return storyboard.initialViewController()
    }
}

extension UIStoryboard {
    func initialViewController<T: UIViewController>() -> T {
        return self.instantiateInitialViewController() as! T
    }
}
