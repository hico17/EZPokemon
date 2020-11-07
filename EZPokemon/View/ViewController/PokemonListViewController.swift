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
            if pokemonCollectionView.numberOfItems(inSection: 0) == 0 {
                isLoading ? activityIndicatorView.startAnimating() : activityIndicatorView.stopAnimating()
            }
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
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        pokemonCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private
    
    private let viewModel: PokemonListViewModel
    private let disposeBag = DisposeBag()
    private var shownIndices = [IndexPath]()
    
    private lazy var pokemonCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .clear
        collectionView.alwaysBounceVertical = true
        collectionView.delegate = self
        collectionView.register(PokemonListItemCollectionViewCell.self)
        return collectionView
    }()
    
    private lazy var messageView: MessageView = {
        let messageView = MessageView(frame: .zero)
        return messageView
    }()
    
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.hidesWhenStopped = true
        return activityIndicatorView
    }()
    
    private func bindData() {
        viewModel.title.bind(to: rx.title).disposed(by: disposeBag)
        viewModel.pokemonListItemViewModels.observe(on: MainScheduler.instance).bind(to: pokemonCollectionView.rx.items(cellIdentifier: PokemonListItemCollectionViewCell.reusableIdentifier, cellType: PokemonListItemCollectionViewCell.self)) { index, viewModel, cell in
            cell.viewModel = viewModel
        }.disposed(by: disposeBag)
        pokemonCollectionView.rx.willDisplayCell.subscribe { [weak self] cell, indexPath in
            guard let self = self else { return }
            if !self.shownIndices.contains(indexPath) {
                self.shownIndices.append(indexPath)
                cell.alpha = 0
                UIView.animate(withDuration: 0.3) {
                    cell.alpha = 1
                }
            }
            self.viewModel.willShow(viewModelAtIndex: indexPath.row)
            let numberOfItems = self.pokemonCollectionView.numberOfItems(inSection: 0)
            if numberOfItems != 0, indexPath.row == numberOfItems-1 {
                self.viewModel.didScrollToEnd()
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
        view.addSubview(activityIndicatorView)
    }
    
    func addConstraints() {
        activityIndicatorView.constraint(to: view)
        NSLayoutConstraint.activateWithoutResizingMasks([
            pokemonCollectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            pokemonCollectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
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

// MARK: - UICollectionViewDelegateFlowLayout

extension PokemonListViewController: UICollectionViewDelegateFlowLayout {
    
    private var numberOfPokemons: CGFloat { 3 }
    private var spacing: CGFloat { 17 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalEmptySpace: CGFloat = spacing * (numberOfPokemons - 1) + spacing + spacing
        return CGSize(width: (collectionView.bounds.width - totalEmptySpace) / numberOfPokemons, height: (collectionView.bounds.width - totalEmptySpace) / numberOfPokemons)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
}
