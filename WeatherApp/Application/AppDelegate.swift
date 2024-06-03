//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by Zuhair Hussain on 03/06/2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var coordinator: Coordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print("[application] didFinishLaunchingWithOptions")
        window = UIWindow()
        coordinator = AppCoordinator(window: window!, factory: ViewControllerFactory())
        coordinator?.start()
        
        return true
    }
}

