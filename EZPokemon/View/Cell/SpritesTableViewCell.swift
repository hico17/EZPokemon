//
//  SpritesTableViewCell.swift
//  EZPokemon
//
//  Created by Luca Celiento on 01/11/2020.
//

import UIKit
import Utilities
import RxSwift

class SpritesTableViewCell: UITableViewCell, Reusable {
    
    var viewModel: SpritesViewModel? {
        didSet {
            viewModel?.images.observe(on: MainScheduler.instance).bind(to: collectionView.rx.items(cellIdentifier: ImageCollectionViewCell.reusableIdentifier, cellType: ImageCollectionViewCell.self)) { index, image, cell in
                cell.image = image
            }.disposed(by: disposeBag)
            viewModel?.isLoading.bind(to: activityIndicatorView.rx.isAnimating).disposed(by: disposeBag)
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
    
    private lazy var collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: bounds, collectionViewLayout: collectionViewLayout)
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.alwaysBounceHorizontal = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(ImageCollectionViewCell.self)
        return collectionView
    }()
    
    private var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicatorView.hidesWhenStopped = true
        return activityIndicatorView
    }()
    
    private func commonInit() {
        addSubviews()
        addConstraints()
    }
}

// MARK: - CodeDesignable

extension SpritesTableViewCell: CodeDesignable {
    
    func addSubviews() {
        contentView.addSubview(collectionView)
        contentView.addSubview(activityIndicatorView)
    }
    
    func addConstraints() {
        collectionView.constraint(to: contentView)
        activityIndicatorView.constraint(to: contentView)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension SpritesTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.height, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let numberOfItems = 4
        let totalItemsWidth: CGFloat = CGFloat(numberOfItems) * collectionView.bounds.height
        let horizontalInset: CGFloat = (collectionView.bounds.width - totalItemsWidth) / 2
        return UIEdgeInsets(top: 0, left: horizontalInset, bottom: 0, right: horizontalInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
