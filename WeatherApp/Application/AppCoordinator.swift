//
//  AppCoordinator.swift
//  WeatherApp
//
//  Created by Zuhair Hussain on 03/06/2024.
//

import UIKit

protocol Coordinator {
    func start()
    func showDetailsView(city: String)
    func navigateBack()
}

class AppCoordinator: Coordinator {
    
    var navigationController: UINavigationController?
    weak var window: UIWindow?
    let factory: ViewControllerFactory
    
    init(window: UIWindow, factory: ViewControllerFactory) {
        self.window = window
        self.factory = factory
    }
    
    func start() {
        let tabBarController = factory.createHomeTabBarController(coordinator: self)
        navigationController = UINavigationController(rootViewController: tabBarController)
        navigationController?.navigationBar.tintColor = .black
        navigationController?.isNavigationBarHidden = true
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func navigateBack() {
        navigationController?.popViewController(animated: true)
    }
    
    func showDetailsView(city: String) {
        let view = factory.createDetailsView(coordinator: self, city: city)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.pushViewController(view, animated: true)
    }
    
}
