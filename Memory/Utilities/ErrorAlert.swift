import UIKit

// MARK: - Extensions to display errors.
extension UIViewController {

    func present(error: Error, title: String = "Error 🤔", animated: Bool, completion: (() -> Swift.Void)? = nil) {
        let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(OKAction)
        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: animated, completion: completion)
        }
    }

}
