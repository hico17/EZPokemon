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
        }
    }
    
    init(viewModel: PokemonListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        let view = UIView(frame: UIScreen.main.bounds)
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }
        self.view = view
        addSubviews()
        addConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
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
    
    private var collectionViewLayout: UICollectionViewFlowLayout {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let numberOfPokemons: CGFloat = 3
        let spacing: CGFloat = 17
        let inset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        let totalEmptySpace = spacing * (numberOfPokemons - 1) + inset.left + inset.right
        let width = (view.frame.width - totalEmptySpace) / numberOfPokemons
        layout.itemSize = CGSize(width: width, height: width)
        layout.sectionInset = inset
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.scrollDirection = .vertical
        return layout
    }
    
    private lazy var messageView: MessageView = {
        let messageView = MessageView(frame: .zero)
        return messageView
    }()
    
    private func bindData() {
        viewModel.title.bind(to: rx.title).disposed(by: disposeBag)
        viewModel.pokemonListItemViewModels.observe(on: MainScheduler.instance).bind(to: pokemonCollectionView.rx.items(cellIdentifier: PokemonListItemCollectionViewCell.reusableIdentifier, cellType: PokemonListItemCollectionViewCell.self)) { index, viewModel, cell in
            cell.viewModel = viewModel
        }.disposed(by: disposeBag)
        pokemonCollectionView.rx.willDisplayCell.subscribe { [weak self] cell, indexPath in
            self?.viewModel.willShow(viewModelAtIndex: indexPath.row)
            if let numberOfItems = self?.pokemonCollectionView.numberOfItems(inSection: 0), numberOfItems != 0, indexPath.row == numberOfItems-1 {
                self?.viewModel.didScrollToEnd()
            }
        }.disposed(by: disposeBag)
        pokemonCollectionView.rx.modelSelected(PokemonListItemViewModel.self).subscribe(onNext: { [weak self] selectedViewModel in
            self?.viewModel.didSelect(viewModel: selectedViewModel)
        }).disposed(by: disposeBag)
        viewModel.isLoading.bind(to: rx.isLoading).disposed(by: disposeBag)
        viewModel.message.observe(on: MainScheduler.instance).subscribe(onNext: { [weak self] message in
            self?.messageView.showAndHide(message: message)
        }).disposed(by: disposeBag)
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
            pokemonCollectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 0),
            pokemonCollectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0),
            pokemonCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor),
            pokemonCollectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            messageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            messageView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            messageView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
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
