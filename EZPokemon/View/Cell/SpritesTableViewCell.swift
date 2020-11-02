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
//        collectionView.collectionViewLayout.invalidateLayout()
        collectionView.collectionViewLayout = collectionViewFlowLayout
    }
    
    // MARK: Private
    
    private var disposeBag = DisposeBag()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: bounds, collectionViewLayout: collectionViewFlowLayout)
        collectionView.backgroundColor = .clear
        collectionView.alwaysBounceHorizontal = true
        collectionView.register(ImageCollectionViewCell.self)
        return collectionView
    }()
    
    private var collectionViewFlowLayout: UICollectionViewFlowLayout {
        let collectionViewLayout = UICollectionViewFlowLayout()
        let padding: CGFloat = 8
        collectionViewLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        let height = bounds.height - collectionViewLayout.sectionInset.top - collectionViewLayout.sectionInset.bottom
        collectionViewLayout.itemSize = CGSize(width: height, height: height)
        collectionViewLayout.minimumInteritemSpacing = padding
        collectionViewLayout.minimumLineSpacing = padding
        collectionViewLayout.scrollDirection = .horizontal
        return collectionViewLayout
    }
    
    private func commonInit() {
        addSubviews()
        addConstraints()
    }
}

// MARK: - CodeDesignable

extension SpritesTableViewCell: CodeDesignable {
    
    func addSubviews() {
        contentView.addSubview(collectionView)
    }
    
    func addConstraints() {
        collectionView.constraint(to: self.contentView)
    }
}
