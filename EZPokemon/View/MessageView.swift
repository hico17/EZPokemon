//
//  MessageView.swift
//  EZPokemon
//
//  Created by Luca Celiento on 31/10/2020.
//

import UIKit
import Utilities

class MessageView: UIView {
    
    var message: String? {
        get {
            messageLabel.text
        }
        set {
            messageLabel.text = newValue
        }
    }
    
    func showAndHide(message: String) {
        alpha = 0
        self.message = message
        UIView.animateKeyframes(withDuration: 0.3, delay: 0, options: .autoreverse) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.3) {
                self.alpha = 1
            }
            UIView.addKeyframe(withRelativeStartTime: 0.7, relativeDuration: 0.3) {
                self.alpha = 0
            }
        }
    }
    
    func show(animated: Bool = true, message: String) {
        alpha = 0
        self.message = message
        UIView.animate(withDuration: animated ? 0.3 : 0) {
            self.alpha = 1
        }
    }
    
    func hide(animated: Bool = true) {
        UIView.animate(withDuration: animated ? 0.3 : 0) {
            self.alpha = 0
        } completion: { _ in
            self.message = nil
        }
    }
    
    convenience init(message: String) {
        self.init(frame: .zero)
        self.message = message
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // MARK: Private
    
    private enum Constants {
        static let blurredBackgroundViewPadding = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        static let messageLabelPadding = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    private func commonInit() {
        backgroundColor = .clear
        alpha = 0
        addSubviews()
        addConstraints()
    }
    
    private let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
    
    private lazy var blurredBackgroundView: UIVisualEffectView = {
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        return blurEffectView
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        return label
    }()
}

// MARK: - CodeDesignable

extension MessageView: CodeDesignable {
    
    func addSubviews() {
        addSubview(blurredBackgroundView)
        blurredBackgroundView.contentView.addSubview(messageLabel)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activateWithoutResizingMasks([
            blurredBackgroundView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Constants.blurredBackgroundViewPadding.top),
            blurredBackgroundView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: Constants.blurredBackgroundViewPadding.left),
            blurredBackgroundView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: Constants.blurredBackgroundViewPadding.bottom),
            blurredBackgroundView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -Constants.blurredBackgroundViewPadding.right),
            messageLabel.topAnchor.constraint(equalTo: blurredBackgroundView.topAnchor, constant: Constants.messageLabelPadding.top),
            messageLabel.leftAnchor.constraint(equalTo: blurredBackgroundView.leftAnchor, constant: Constants.messageLabelPadding.left),
            messageLabel.bottomAnchor.constraint(equalTo: blurredBackgroundView.bottomAnchor, constant: Constants.messageLabelPadding.bottom),
            messageLabel.rightAnchor.constraint(equalTo: blurredBackgroundView.rightAnchor, constant: Constants.messageLabelPadding.right)
        ])
    }
}
