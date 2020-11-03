//
//  SpritesTableViewCell.swift
//  EZPokemon
//
//  Created by Luca Celiento on 01/11/2020.
//

import UIKit
import Utilities
import RxSwift

class SpriteTableViewCell: UITableViewCell, Reusable {
    
    var viewModel: SpriteViewModel? {
        didSet {
            viewModel?.image.bind(to: spriteImageView.rx.image).disposed(by: disposeBag)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
    
    private lazy var spriteImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private func commonInit() {
        addSubviews()
        addConstraints()
    }
}

// MARK: - CodeDesignable

extension SpriteTableViewCell: CodeDesignable {
    
    func addSubviews() {
        contentView.addSubview(spriteImageView)
    }
    
    func addConstraints() {
        spriteImageView.constraint(to: contentView, padding: UIEdgeInsets(top: 17, left: 17, bottom: -17, right: -17))
    }
}
