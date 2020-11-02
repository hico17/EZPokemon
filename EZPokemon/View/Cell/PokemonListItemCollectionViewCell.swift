//
//  PokemonListItemCollectionViewCell.swift
//  EZPokemon
//
//  Created by Luca Celiento on 31/10/2020.
//

import UIKit
import RxSwift
import Utilities

class PokemonListItemCollectionViewCell: UICollectionViewCell, Reusable {
    
    var viewModel: PokemonListItemViewModel? {
        didSet {
            viewModel?.isLoading.bind(to: rx.isLoading).disposed(by: disposeBag)
            viewModel?.image.bind(to: imageView.rx.image).disposed(by: disposeBag)
            viewModel?.name.subscribe(onNext: { [weak self] name in
                self?.nameLabel.text = name
                }).disposed(by: disposeBag)
        }
    }
    
    var isLoading: Bool = true {
        didSet {
            if isLoading {
                activityIndicatorView.startAnimating()
                imageView.isHidden = true
            } else {
                activityIndicatorView.stopAnimating()
                imageView.isHidden = false
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
        imageView.image = nil
        nameLabel.text = nil
        activityIndicatorView.stopAnimating()
    }
    
    // MARK: Private
    
    private enum Constants {
        static let namePadding = UIEdgeInsets(top: 0, left: 4, bottom: -8, right: -4)
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
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()
    
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.color = UIColor.systemGray
        activityIndicatorView.hidesWhenStopped = true
        return activityIndicatorView
    }()
    
    private func commonInit() {
        addSubviews()
        addConstraints()
    }
}

// MARK: - CodeDesignable

extension PokemonListItemCollectionViewCell: CodeDesignable {
    
    func addSubviews() {
        contentView.addSubview(shadowView)
        shadowView.addSubview(roundedView)
        roundedView.contentView.addSubview(nameLabel)
        roundedView.contentView.addSubview(imageView)
        roundedView.contentView.addSubview(activityIndicatorView)
    }
    
    func addConstraints() {
        shadowView.constraint(to: self.contentView)
        roundedView.constraint(to: shadowView)
        NSLayoutConstraint.activateWithoutResizingMasks([
            imageView.topAnchor.constraint(equalTo: roundedView.topAnchor),
            imageView.leftAnchor.constraint(equalTo: roundedView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: roundedView.rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: Constants.namePadding.top),
            nameLabel.leftAnchor.constraint(equalTo: roundedView.leftAnchor, constant: Constants.namePadding.left),
            nameLabel.rightAnchor.constraint(equalTo: roundedView.rightAnchor, constant: Constants.namePadding.right),
            nameLabel.bottomAnchor.constraint(equalTo: roundedView.bottomAnchor, constant: Constants.namePadding.bottom),
            activityIndicatorView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
        ])
    }
}

// MARK: - Reactive extensions

extension Reactive where Base: PokemonListItemCollectionViewCell {
    
    var isLoading: Binder<Bool> {
        return Binder(self.base) { cell, isLoading in
            cell.isLoading = isLoading
        }
    }
}
