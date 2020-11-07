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
        let splitViewController = UISplitViewController()
        splitViewController.viewControllers = [pokemonListCoordinator.navigationController, UIViewController()]
        splitViewController.preferredDisplayMode = .allVisible
        splitViewController.delegate = self
        rootViewController = splitViewController
    }
    
    init() {}
}

// MARK: - UISplitViewControllerDelegate

extension AppCoordinator: UISplitViewControllerDelegate {
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
}
