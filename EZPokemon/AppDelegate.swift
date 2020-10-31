//
//  AppDelegate.swift
//  EZPokemon
//
//  Created by Luca Celiento on 29/10/2020.
//

import UIKit
import Utilities

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        guard #available(iOS 13, *) else {
            window = UIWindow()
            let coordinator = PokemonListCoordinator(navigationController: UINavigationController())
            window?.rootViewController = coordinator.navigationController
            window?.makeKeyAndVisible()
            coordinator.start()
            return true
        }
        return true
    }
    
    var window: UIWindow?
    
    // MARK: Private
    
    private var appCoordinator: Coordinator?
}

