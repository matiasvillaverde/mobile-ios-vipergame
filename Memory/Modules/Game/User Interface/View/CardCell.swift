//
//  CardCell.swift
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

import UIKit

/// View of a Card.
class CardCell: UICollectionViewCell {

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
            bringSubview(toFront: frontImageView)
            backImageView.isHidden = true
        } else {
            bringSubview(toFront: backImageView)
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
