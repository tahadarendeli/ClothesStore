//
//  DetailContainerCoordinator.swift
//  Clothes Store
//
//  Created by Mentor on 3.06.2021.
//  Copyright © 2021 RichieHope. All rights reserved.
//

import UIKit

final class DetailContainerCoordinator: Coordinator {
    var navigationController: UINavigationController?
    var children: [Coordinator]? = nil
    private let product: ProductPresentable?
    
    internal init() {
        product = nil
    }
    
    init(product: ProductPresentable) {
        self.product = product
    }
    
    func start() {
        let viewController = DetailViewContainerViewController.instantiate(with: Strings.Identifiers.Storyboard.detail.rawValue)
        let presenter = DetailPresenter(with: viewController,
                                        basketMemoryService: BasketMemoryService.shared(),
                                        wishlistMemoryService: WishlistMemoryService.shared())
        presenter.product = product
        viewController.presenter = presenter
        viewController.coordinator = self
        
        navigationController?.setViewControllers([viewController], animated: false)
    }
}

