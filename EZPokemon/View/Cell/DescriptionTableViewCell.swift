//
//  DescriptionTableViewCell.swift
//  EZPokemon
//
//  Created by Luca Celiento on 03/11/2020.
//

import UIKit
import RxSwift
import Utilities

class DescriptionTableViewCell: UITableViewCell, Reusable {
    
    var viewModel: DescriptionViewModel? {
        didSet {
            viewModel?.gameDescription.bind(to: gameLabel.rx.text).disposed(by: disposeBag)
            viewModel?.flavorText.bind(to: descriptionLabel.rx.text).disposed(by: disposeBag)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // MARK: - Private
    
    private var disposeBag = DisposeBag()
    
    private lazy var gameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont.italicSystemFont(ofSize: 17)
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private func commonInit() {
        addSubviews()
        addConstraints()
    }
}

// MARK: - CodeDesignable

extension DescriptionTableViewCell: CodeDesignable {
    
    func addSubviews() {
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(gameLabel)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activateWithoutResizingMasks([
            descriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            descriptionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 17),
            descriptionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -17),
            descriptionLabel.bottomAnchor.constraint(equalTo: gameLabel.topAnchor, constant: -8),
            gameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 17),
            gameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -17),
            gameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}
