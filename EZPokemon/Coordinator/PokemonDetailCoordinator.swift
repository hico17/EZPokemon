//
//  PokemonDetailCoordinator.swift
//  EZPokemon
//
//  Created by Luca Celiento on 01/11/2020.
//

import UIKit
import Utilities

struct PokemonDetailCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    func start() {
        let viewModel = PokemonDetailViewModel(pokemonListItem: pokemonListItem, pokemonDetail: pokemonDetail, pokemonDetailService: PokemonDetailService(), pokemonSpriteService: PokemonSpriteService())
        let pokemonDetailViewController = PokemonDetailViewController(viewModel: viewModel)
        let navCon = UINavigationController(rootViewController: pokemonDetailViewController)
        navigationController.showDetailViewController(navCon, sender: nil)
    }
    
    init(navigationController: UINavigationController, pokemonListItem: PokemonListItem, pokemonDetail: PokemonDetail?) {
        self.navigationController = navigationController
        self.pokemonListItem = pokemonListItem
        self.pokemonDetail = pokemonDetail
    }
    
    // MARK: Private
    
    private let pokemonListItem: PokemonListItem
    private let pokemonDetail: PokemonDetail?
}
