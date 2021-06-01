//
//  CatalogueCoordinator.swift
//  Clothes Store
//
//  Created by Mentor on 1.06.2021.
//  Copyright © 2021 RichieHope. All rights reserved.
//

import UIKit

final class CatalogueCoordinator: Coordinator {
    var navigationController: UINavigationController?
    var children: [Coordinator]? = nil
    
    func start() {
        var viewController: CoordinatingViewController = CatalogueViewController.instantiate(with: Strings.Identifiers.Storyboard.catalogue.rawValue)
        viewController.coordinator = self
        
        navigationController?.setViewControllers([viewController], animated: false)
    }
    
    func showDetail(product: Product) {
        let rootViewController = DetailViewContainerViewController.instantiate(with: Strings.Identifiers.Storyboard.detail.rawValue)
        let viewController = UINavigationController(rootViewController: rootViewController)
        
        rootViewController.product = product
        
        self.navigationController?.modalPresentationStyle = .formSheet
        self.navigationController?.present(viewController, animated: true, completion: nil)
    }
}
