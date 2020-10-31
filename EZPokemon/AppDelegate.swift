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
            let coordinator = AppCoordinator()
//            let coordinator = PokemonListCoordinator(navigationController: UINavigationController())
            coordinator.start()
            window?.rootViewController = coordinator.rootViewController
            window?.makeKeyAndVisible()
            return true
        }
        return true
    }
    
    var window: UIWindow?
    
    // MARK: Private
    
    private var appCoordinator: AppCoordinator?
}

