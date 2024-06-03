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
        let view = factory.createMainView(coordinator: self)
        navigationController = UINavigationController(rootViewController: view)
        navigationController?.navigationBar.tintColor = .black
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func navigateBack() {
        navigationController?.popViewController(animated: true)
    }
    
    func showDetailsView(city: String) {
        let view = factory.createDetailsView(coordinator: self, city: city)
        navigationController?.pushViewController(view, animated: true)
    }
    
}
