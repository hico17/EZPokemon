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
    
    var header: String? {
        get {
            headerLabel.text
        }
        set {
            headerLabel.text = newValue
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
        if #available(iOS 13.0, *) {
            backgroundColor = .systemGroupedBackground
        } else {
            backgroundColor = .groupTableViewBackground
        }
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
