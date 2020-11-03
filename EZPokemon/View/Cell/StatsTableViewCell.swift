//
//  StatsTableViewCell.swift
//  EZPokemon
//
//  Created by Luca Celiento on 03/11/2020.
//

import UIKit
import Utilities
import RxSwift

class StatsTableViewCell: UITableViewCell, Reusable {
    
    var viewModel: StatsViewModel? {
        didSet {
            viewModel?.viewModels.bind(to: collectionView.rx.items(cellIdentifier: StatCollectionViewCell.reusableIdentifier, cellType: StatCollectionViewCell.self)) { index, viewModel, cell in
                cell.viewModel = viewModel
            }.disposed(by: disposeBag)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.collectionViewLayout = collectionViewLayout
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
    
    private var disposeBag = DisposeBag()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        collectionView.backgroundColor = .clear
        collectionView.alwaysBounceHorizontal = true
        collectionView.register(StatCollectionViewCell.self)
        return collectionView
    }()
    
    private var collectionViewLayout: UICollectionViewFlowLayout {
        let collectionViewLayout = UICollectionViewFlowLayout()
        let padding: CGFloat = 17
        collectionViewLayout.itemSize = CGSize(width: 100, height: collectionView.bounds.height - padding*2)
        collectionViewLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
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

extension StatsTableViewCell: CodeDesignable {
    
    func addSubviews() {
        contentView.addSubview(collectionView)
    }
    
    func addConstraints() {
        collectionView.constraint(to: contentView)
    }
}
