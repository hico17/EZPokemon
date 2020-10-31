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
            viewModel?.fetchData()
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
    
    private var disposeBag = DisposeBag()
    
    private lazy var imageView: UIImageView = {
        let label = UIImageView()
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
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
        addSubview(nameLabel)
        addSubview(imageView)
        addSubview(activityIndicatorView)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activateWithoutResizingMasks([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leftAnchor.constraint(equalTo: leftAnchor),
            imageView.rightAnchor.constraint(equalTo: rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor),
            nameLabel.leftAnchor.constraint(equalTo: leftAnchor),
            nameLabel.rightAnchor.constraint(equalTo: rightAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
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
