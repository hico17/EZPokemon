//
//  HeaderTableViewCell.swift
//  EZPokemon
//
//  Created by Luca Celiento on 01/11/2020.
//

import Foundation
import Utilities
import RxSwift

class HeaderTableViewCell: UITableViewCell, Reusable {
    
    var viewModel: HeaderViewModel? {
        didSet {
            viewModel?.header.bind(to: headerLabel.rx.text).disposed(by: disposeBag)
            viewModel?.color.bind(to: rx.backgroundColor).disposed(by: disposeBag)
            viewModel?.color.subscribe(onNext: { [weak self] color in
                self?.headerLabel.textColor = color.isLight ? .black : .white
            }).disposed(by: disposeBag)
            
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        headerLabel.textColor = backgroundColor?.isLight ?? true ? .black : .white
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    // MARK: Private
    
    private enum Constants {
        static let padding = UIEdgeInsets(top: 8, left: 17, bottom: -8, right: -17)
    }
    
    private var disposeBag = DisposeBag()

    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    private func commonInit() {
        addSubviews()
        addConstraints()
    }
}

// MARK: - CodeDesignable

extension HeaderTableViewCell: CodeDesignable {
    
    func addSubviews() {
        contentView.addSubview(headerLabel)
    }
    
    func addConstraints() {
        headerLabel.constraint(to: contentView, padding: Constants.padding)
    }
}
