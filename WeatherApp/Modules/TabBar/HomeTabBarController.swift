//
//  HomeTabBarController.swift
//  WeatherApp
//
//  Created by Zuhair Hussain on 04/06/2024.
//

import UIKit

class HomeTabBarController: UITabBarController {
    
    var factory: ViewControllerFactory!
    var coordinator: Coordinator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    init(factory: ViewControllerFactory, coordinator: Coordinator) {
        self.factory = factory
        self.coordinator = coordinator
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupUI() {
        let main = factory.createMainView(coordinator: coordinator, favorites: false)
        let favorites = factory.createMainView(coordinator: coordinator, favorites: true)
        
        main.title = "Home"
        main.tabBarItem.image = UIImage(systemName: "house")
        main.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        
        favorites.title = "Favorites"
        favorites.showAddButton = false
        favorites.tabBarItem.image = UIImage(systemName: "heart")
        favorites.tabBarItem.selectedImage = UIImage(systemName: "heart.fill")
        
        self.viewControllers = [main.inNavigationController(), favorites.inNavigationController()]
    }

}
