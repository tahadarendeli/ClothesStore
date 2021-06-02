//
//  BasketCoordinator.swift
//  Clothes Store
//
//  Created by Mentor on 1.06.2021.
//  Copyright © 2021 RichieHope. All rights reserved.
//

import UIKit

final class BasketCoordinator: Coordinator {
    var navigationController: UINavigationController?
    var children: [Coordinator]? = nil
    
    func start() {
        let viewController = BasketViewController.instantiate(with: Strings.Identifiers.Storyboard.basket.rawValue)
        let presenter = BasketPresenter(with: viewController,
                                        basketMemoryService: BasketMemoryService.shared(),
                                        productMemoryService: ProductMemoryService.shared())
        
        viewController.presenter = presenter
        viewController.coordinator = self
        
        navigationController?.setViewControllers([viewController], animated: false)
    }
}
