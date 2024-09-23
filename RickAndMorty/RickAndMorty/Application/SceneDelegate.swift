//
//  SceneDelegate.swift
//  RickAndMorty
//
//  Created by Nikita Beglov on 23.09.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let moduleBuilder = ModuleBuilder()
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = moduleBuilder.createListViewController()
        window?.makeKeyAndVisible()
    }
    
}

