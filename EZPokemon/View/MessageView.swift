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
        UIView.animateKeyframes(withDuration: 3, delay: 0, options: .autoreverse) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.05) {
                self.alpha = 1
            }
        } completion: { completed in
            if completed {
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
        static let blurredBackgroundViewPadding = UIEdgeInsets(top: 8, left: 8, bottom: -8, right: -8)
        static let messageLabelPadding = UIEdgeInsets(top: 17, left: 17, bottom: -17, right: -17)
    }
        
    private lazy var blurredBackgroundView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.layer.cornerRadius = 8
        blurEffectView.layer.masksToBounds = true
        return blurEffectView
    }()

    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        return label
    }()
    
    private func commonInit() {
        alpha = 0
        addSubviews()
        addConstraints()
    }
}

// MARK: - CodeDesignable

extension MessageView: CodeDesignable {
    
    func addSubviews() {
        addSubview(blurredBackgroundView)
        blurredBackgroundView.contentView.addSubview(messageLabel)
    }
    
    func addConstraints() {
        blurredBackgroundView.constraint(to: self, padding: Constants.blurredBackgroundViewPadding)
        messageLabel.constraint(to: blurredBackgroundView, padding: Constants.messageLabelPadding)
    }
}
