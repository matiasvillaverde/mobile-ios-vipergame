import UIKit

/// View of a Card.
final class CardCell: UICollectionViewCell {

    static let identifier = "CardCellID"
    private let animationDuration = 0.5
    private(set) var shown = false
    var card: Card?

    // Subviews
    private let frontImageView = UIImageView()
    private let backImageView = UIImageView(image: UIImage(named: "card_back"))

}

// MARK: - Life cycle.
extension CardCell {

    override func draw(_ rect: CGRect) {
        contentView.addSubview(backImageView)
        contentView.addSubview(frontImageView)
        frontImageView.frame = rect
        backImageView.frame = rect
        contentView.backgroundColor = .white
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        frontImageView.image = nil        
    }

}

// MARK: - Add Subviews.
extension CardCell {

    private func addImage() {
        guard let card = card else { return }
        UIImage.download(image: card.content.imageURL, completion: { [weak self] (image) in
            self?.frontImageView.image = image
        })
    }

}

// MARK: - Actions.
extension CardCell {

    func show(animated: Bool) {

            frontImageView.image = nil
            addImage()

            frontImageView.isHidden = false
            backImageView.isHidden = false
            shown = !shown

            animated ? flipAnimated() : flip()
    }

    private func flip() {
        if shown {
            bringSubviewToFront(frontImageView)
            backImageView.isHidden = true
        } else {
            bringSubviewToFront(backImageView)
            frontImageView.isHidden = true
        }
    }

    private func flipAnimated() {
        if shown {
            UIView.transition(from: backImageView,
                              to: frontImageView,
                              duration: animationDuration,
                              options: [.transitionFlipFromRight, .showHideTransitionViews],
                              completion: nil)
        } else {
            UIView.transition(from: frontImageView,
                              to: backImageView,
                              duration: animationDuration,
                              options: [.transitionFlipFromRight, .showHideTransitionViews],
                              completion: nil)
        }
    }

}
