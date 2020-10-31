//
//  AppCoordinator.swift
//  EZPokemon
//
//  Created by Luca Celiento on 01/11/2020.
//

import UIKit
import Utilities

class AppCoordinator {
    
    var childCoordinators = [Coordinator]()
    var rootViewController: UIViewController?
    
    func start() {
        let pokemonListCoordinator = PokemonListCoordinator(navigationController: UINavigationController())
        childCoordinators.append(pokemonListCoordinator)
        pokemonListCoordinator.start()
        let pokemonListCoordinator2 = PokemonListCoordinator(navigationController: UINavigationController())
        childCoordinators.append(pokemonListCoordinator2)
        pokemonListCoordinator2.start()
        splitViewController.viewControllers = [pokemonListCoordinator.navigationController, pokemonListCoordinator2.navigationController]
        rootViewController = splitViewController
    }
    
    init() {
        
    }
    
    private lazy var splitViewController: UISplitViewController = {
        let splitViewController = UISplitViewController()
        splitViewController.preferredDisplayMode = .allVisible
        splitViewController.delegate = self
        return splitViewController
    }()
}

// MARK: - UISplitViewControllerDelegate

extension AppCoordinator: UISplitViewControllerDelegate {
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
}
