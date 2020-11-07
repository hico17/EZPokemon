//
//  SceneDelegate.swift
//  EZPokemon
//
//  Created by Luca Celiento on 29/10/2020.
//

import UIKit
import Utilities

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            self.window = UIWindow(windowScene: windowScene)
            appCoordinator = AppCoordinator()
            appCoordinator?.start()
//            appCoordinator = PokemonListCoordinator(navigationController: UINavigationController())
            self.window?.rootViewController = appCoordinator?.rootViewController
            self.window?.makeKeyAndVisible()
        }
    }
    
    // MARK: Private
    
    private var appCoordinator: AppCoordinator?
}

