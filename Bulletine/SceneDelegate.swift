//
//  SceneDelegate.swift
//  Bulletine
//
//  Created by snlcom on 6/6/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // 이 메서드는 앱이 처음 시작될 때 호출됩니다.
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        let launchVC = LaunchViewController()
        let mainViewController = PostListViewController()
        let navigationController = UINavigationController(rootViewController: mainViewController)
        
        window?.rootViewController = launchVC
        window?.makeKeyAndVisible()
    }

    
}

