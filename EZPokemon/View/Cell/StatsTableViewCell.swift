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
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.alwaysBounceHorizontal = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(StatCollectionViewCell.self)
        return collectionView
    }()
    
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

// MARK: - UICollectionViewDelegateFlowLayout

extension StatsTableViewCell: UICollectionViewDelegateFlowLayout {
    
    private var padding: CGFloat { 17 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: collectionView.bounds.height - padding * 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return padding
    }
}
