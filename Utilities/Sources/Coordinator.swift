//
//  Coordinator.swift
//  EZPokemon
//
//  Created by Luca Celiento on 29/10/2020.
//

import UIKit

public protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    func start()
}
