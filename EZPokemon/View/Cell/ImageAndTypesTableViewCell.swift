//
//  SpritesTableViewCell.swift
//  EZPokemon
//
//  Created by Luca Celiento on 01/11/2020.
//

import UIKit
import Utilities
import RxSwift

class ImageAndTypesTableViewCell: UITableViewCell, Reusable {
    
    var viewModel: ImageAndTypeViewModel? {
        didSet {
            viewModel?.isLoading.bind(to: activityIndicatorView.rx.isAnimating).disposed(by: disposeBag)
            viewModel?.image.bind(to: spriteImageView.rx.image).disposed(by: disposeBag)
            viewModel?.types.bind(to: label.rx.text).disposed(by: disposeBag)
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        roundedView.layer.cornerRadius = roundedView.bounds.height / 2
    }
    
    // MARK: Private
    
    private var disposeBag = DisposeBag()
    
    private lazy var spriteImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var roundedView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .regular)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.layer.cornerRadius = 8
        visualEffectView.layer.masksToBounds = true
        return visualEffectView
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 15)
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(style: .white)
        activityIndicatorView.hidesWhenStopped = true
        return activityIndicatorView
    }()
    
    private func commonInit() {
        addSubviews()
        addConstraints()
    }
}

// MARK: - CodeDesignable

extension ImageAndTypesTableViewCell: CodeDesignable {
    
    func addSubviews() {
        contentView.addSubview(spriteImageView)
        contentView.addSubview(activityIndicatorView)
        contentView.addSubview(roundedView)
        roundedView.contentView.addSubview(label)
    }
    
    func addConstraints() {
        activityIndicatorView.constraint(to: spriteImageView)
        label.constraint(to: roundedView, padding: UIEdgeInsets(top: 0, left: 17, bottom: 0, right: -17))
        NSLayoutConstraint.activateWithoutResizingMasks([
            spriteImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 17),
            spriteImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 17),
            spriteImageView.bottomAnchor.constraint(equalTo: roundedView.topAnchor, constant: -8),
            spriteImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -17),
            roundedView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            roundedView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -17)
        ])
    }
}
