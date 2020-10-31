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
            viewModel?.name.subscribe(onNext: { name in
                self.nameLabel.text = name
                }).disposed(by: disposeBag)
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
    }
    
    // MARK: Private
    
    private var disposeBag = DisposeBag()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        return label
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
    }
    
    func addConstraints() {
        NSLayoutConstraint.activateWithoutResizingMasks([
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
