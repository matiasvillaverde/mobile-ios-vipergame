import UIKit

/// Cache image on Memory Game.
private let imageCache = NSCache<NSString, UIImage>()

extension UIImage {

    /// Download image from URL, and persist it on disk.
    ///
    /// - Parameters:
    ///   - url: image remote url.
    ///   - completion: callback in main thread with the image on Memory Game.
    static func download(image url: URL, completion: ((UIImage?) -> Void)?) {

        // Search locally.
        guard !searchCached(image: url, completion: completion) else { return }

        // Search remote.
        searchRemote(image: url, completion: completion)

    }

    /// SYNC: search for image in local disk.
    ///
    /// - Parameters:
    ///   - url: image local resource.
    ///   - completion: callback in main thread with the image on Memory Game.
    /// - Returns: if the image was found, or not.
    static func searchCached(image url: URL, completion: ((UIImage?) -> Void)?) -> Bool {
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            DispatchQueue.main.async {
                completion?(cachedImage)
            }
            return true
        }
        return false
    }

    /// ASYNC: Download image from URL.
    ///
    /// - Parameters:
    ///   - url: image remote resource.
    ///   - completion: async callback with the image on Memory Game.
    static func searchRemote(image url: URL, completion: ((UIImage?) -> Void)?) {

        // Perform async task.
        DispatchQueue.global(qos: .background).async {
            var image: UIImage?

            // Return result.
            defer {
                DispatchQueue.main.async {
                    completion?(image)
                }
            }

            // Download image.
            guard let data = try? Data(contentsOf: url) else { return }
            image = UIImage(data: data)

            // Save image locally.
            guard let imageToSave = image else { return }
            imageCache.setObject(imageToSave, forKey: url.absoluteString as NSString)
        }

    }

}
