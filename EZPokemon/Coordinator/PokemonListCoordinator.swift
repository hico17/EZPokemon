//
//  PokemonListCoordinator.swift
//  EZPokemon
//
//  Created by Luca Celiento on 29/10/2020.
//

import UIKit
import Utilities

class PokemonListCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    func start() {
        let viewModel = PokemonListViewModel(pokemonListService: pokemonListService, pokemonDetailService: pokemonDetailService, pokemonSpriteService: pokemonSpriteService)
        viewModel.delegate = self
        let pokemonListViewController = PokemonListViewController(viewModel: viewModel)
        navigationController.show(pokemonListViewController, sender: nil)
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    private let pokemonListService = PokemonListService()
    private let pokemonDetailService = PokemonDetailService()
    private let pokemonSpriteService = PokemonSpriteService()
}

// MARK: - PokemonListViewModelDelegate

extension PokemonListCoordinator: PokemonListViewModelDelegate {
    
    func pokemonListViewModel(_ pokemonListViewModel: PokemonListViewModel, didSelectItem item: PokemonListItemViewModel) {
        let coordinator = PokemonDetailCoordinator(navigationController: navigationController, pokemonListItem: item.pokemonListItem, pokemonDetail: item.pokemonDetail)
        childCoordinators.append(coordinator)
        coordinator.start()
    }
}
