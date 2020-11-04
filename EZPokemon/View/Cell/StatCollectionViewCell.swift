//
//  StatCollectionViewCell.swift
//  EZPokemon
//
//  Created by Luca Celiento on 03/11/2020.
//

import UIKit
import Utilities
import RxSwift

class StatCollectionViewCell: UICollectionViewCell, Reusable {
    
    var viewModel: StatViewModel? {
        didSet {
            viewModel?.name.bind(to: nameLabel.rx.text).disposed(by: disposeBag)
            viewModel?.baseStat.bind(to: valueLabel.rx.text).disposed(by: disposeBag)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
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
        static let labelFont = UIFont.systemFont(ofSize: 15, weight: .light)
        static let labelValueFont = UIFont.systemFont(ofSize: 20, weight: .semibold)
    }
    
    private var disposeBag = DisposeBag()
    
    private lazy var shadowView: UIView = {
        let view = UIView()
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 8
        return view
    }()
    
    private lazy var roundedView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .regular)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.layer.cornerRadius = 8
        visualEffectView.layer.masksToBounds = true
        return visualEffectView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = Constants.labelFont
        return label
    }()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.labelValueFont
        return label
    }()
    
    private func commonInit() {
        addSubviews()
        addConstraints()
    }
}

// MARK: - CodeDesignable

extension StatCollectionViewCell: CodeDesignable {
    
    func addSubviews() {
        contentView.addSubview(shadowView)
        shadowView.addSubview(roundedView)
        roundedView.contentView.addSubview(stackView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(valueLabel)
    }
    
    func addConstraints() {
        shadowView.constraint(to: contentView)
        roundedView.constraint(to: shadowView)
        NSLayoutConstraint.activateWithoutResizingMasks([
            stackView.leftAnchor.constraint(lessThanOrEqualTo: roundedView.leftAnchor, constant: 4),
            stackView.rightAnchor.constraint(lessThanOrEqualTo: roundedView.rightAnchor, constant: -4),
            stackView.centerXAnchor.constraint(equalTo: roundedView.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: roundedView.centerYAnchor)
        ])
    }
}
