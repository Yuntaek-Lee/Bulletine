//
//  AppDelegate.swift
//  Bulletine
//
//  Created by snlcom on 6/6/24.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let launchVC = LaunchViewController()
        let rootViewController = PostListViewController()
        let navigationController = UINavigationController(rootViewController: rootViewController)
        
        window?.rootViewController = launchVC
        window?.makeKeyAndVisible()
        
        return true
    }

    // Other AppDelegate methods...
}


