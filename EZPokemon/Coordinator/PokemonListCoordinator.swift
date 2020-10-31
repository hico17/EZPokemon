//
//  PokemonListCoordinator.swift
//  EZPokemon
//
//  Created by Luca Celiento on 29/10/2020.
//

import UIKit
import Utilities

struct PokemonListCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    func start() {
        let viewModel = PokemonListViewModel(pokemonListService: pokemonListService)
        let pokemonListViewController = PokemonListViewController(viewModel: viewModel)
        navigationController.show(pokemonListViewController, sender: nil)
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    private let pokemonListService = PokemonListService()
}
