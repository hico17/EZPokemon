//
//  PokemonListViewController.swift
//  EZPokemon
//
//  Created by Luca Celiento on 29/10/2020.
//

import UIKit
import RxSwift
import RxCocoa

class PokemonListViewController: UIViewController {

    init(viewModel: PokemonListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        addConstraints()
        bindData()
    }

    // MARK: Private
    
    private let viewModel: PokemonListViewModel
    private let disposeBag = DisposeBag()
    
    private lazy var pokemonCollectionView: UICollectionView = {
        let collectionView = UICollectionView()
        collectionView.register(PokemonListItemCollectionViewCell.self)
        return collectionView
    }()
    
    private func bindData() {
        viewModel.fetchPokemonListItemViewModel()
        viewModel.pokemonListItemViewModels.bind(to: pokemonCollectionView.rx.items(cellIdentifier: PokemonListItemCollectionViewCell.reusableIdentifier, cellType: PokemonListItemCollectionViewCell.self)) { index, model, cell in
            
        }.disposed(by: disposeBag)
    }
}

// MARK: - CodeDesignable

extension PokemonListViewController: CodeDesignable {
    
    func addSubviews() {
        view.addSubview(pokemonCollectionView)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            pokemonCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
            pokemonCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor),
            pokemonCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pokemonCollectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
