//
//  AnimatedLogoCoordinator.swift
//  EZPokemon
//
//  Created by Luca Celiento on 29/10/2020.
//

import UIKit
import Utilities

class AnimatedLogoCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    func start() {
        let viewModel = AnimatedLogoViewModel(delegate: self)
        let viewController = AnimatedLogoViewController(viewModel: viewModel)
        navigationController.show(viewController, sender: nil)
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

// MARK: - AnimatedLogoViewModelDelegate

extension AnimatedLogoCoordinator: AnimatedLogoViewModelDelegate {
    
    func didFinishToShowLogo(_ sender: AnimatedLogoViewModel) {
        let coordinator = PokemonListCoordinator(navigationController: navigationController)
        childCoordinators.append(coordinator)
        coordinator.start()
    }
}
