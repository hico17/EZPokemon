//
//  PokemonListViewController.swift
//  EZPokemon
//
//  Created by Luca Celiento on 29/10/2020.
//

import UIKit
import RxSwift
import RxCocoa
import Utilities

class PokemonListViewController: UIViewController {
    
    var isLoading: Bool = false {
        didSet {
            if isLoading {
                messageView.showAndHide(message: "Loading")
            }
        }
    }
    
    init(viewModel: PokemonListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = .white
        self.view = view
        addSubviews()
        addConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
        viewModel.fetchPokemonListItemViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private
    
    private let viewModel: PokemonListViewModel
    private let disposeBag = DisposeBag()
    
    private lazy var pokemonCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .clear
        collectionView.alwaysBounceVertical = true
        collectionView.register(PokemonListItemCollectionViewCell.self)
        return collectionView
    }()
    
    private lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.width / 4, height: 100)
        layout.minimumInteritemSpacing = 8
        layout.scrollDirection = .vertical
        return layout
    }()
    
    private lazy var messageView: MessageView = {
        let messageView = MessageView(frame: .zero)
        return messageView
    }()
    
    private func bindData() {
        viewModel.title.subscribe(onNext: { title in
            self.title = title
        }).disposed(by: disposeBag)
        viewModel.pokemonListItemViewModels.observe(on: MainScheduler.instance).bind(to: pokemonCollectionView.rx.items(cellIdentifier: PokemonListItemCollectionViewCell.reusableIdentifier, cellType: PokemonListItemCollectionViewCell.self)) { index, viewModel, cell in
            cell.viewModel = viewModel
        }.disposed(by: disposeBag)
        pokemonCollectionView.rx.willDisplayCell.subscribe { cell, indexPath in
            let numberOfItems = self.pokemonCollectionView.numberOfItems(inSection: 0)
            if indexPath.row == numberOfItems-1 {
                self.viewModel.fetchPokemonListItemViewModel()
            }
        }.disposed(by: disposeBag)
        viewModel.isLoading.bind(to: rx.isLoading).disposed(by: disposeBag)
    }
}

// MARK: - CodeDesignable

extension PokemonListViewController: CodeDesignable {
    
    func addSubviews() {
        view.addSubview(pokemonCollectionView)
        view.addSubview(messageView)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activateWithoutResizingMasks([
            pokemonCollectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 8),
            pokemonCollectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -8),
            pokemonCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor),
            pokemonCollectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            messageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            messageView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            messageView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            messageView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}

// MARK: - Reactive extensions

extension Reactive where Base: PokemonListViewController {
    
    var isLoading: Binder<Bool> {
        return Binder(self.base) { vc, isLoading in
            vc.isLoading = isLoading
        }
    }
}
