//
//  PokemonListItemCollectionViewCell.swift
//  EZPokemon
//
//  Created by Luca Celiento on 31/10/2020.
//

import UIKit
import Utilities

class PokemonListItemCollectionViewCell: UICollectionViewCell, Reusable {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // MARK: Private
    
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
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
