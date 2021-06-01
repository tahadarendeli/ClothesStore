//
//  MainCoordinator.swift
//  Clothes Store
//
//  Created by Mentor on 1.06.2021.
//  Copyright © 2021 RichieHope. All rights reserved.
//

import UIKit

typealias CoordinatingViewController = UIViewController & Coordinating

final class MainCoordinator: Coordinator {
    var navigationController: UINavigationController?
    var children: [Coordinator]? = []
    
    func start() {
        var viewController: CoordinatingViewController = TabBarController.instantiate(with: Strings.Identifiers.Storyboard.main.rawValue)
        viewController.coordinator = self
        
        generateChildCoordinators()
        
        (viewController as! UITabBarController).viewControllers = children?.compactMap({ $0.navigationController })
        navigationController?.setViewControllers([viewController], animated: false)
    }
    
    func generateChildCoordinators() {
        children?.append(generateGenericCoordinator(for: CatalogueCoordinator.self))
        children?.append(generateGenericCoordinator(for: WishlistCoordinator.self))
        children?.append(generateGenericCoordinator(for: BasketCoordinator.self))
        children?.append(generateGenericCoordinator(for: CatalogueViewCoordinator.self))
    }
    
    func generateGenericCoordinator<T: Coordinator>(for type: T.Type) -> T {
        let navigationController = UINavigationController()
        var coordinator = T()
        coordinator.navigationController = navigationController
        
        coordinator.start()
        
        return coordinator
    }
}
