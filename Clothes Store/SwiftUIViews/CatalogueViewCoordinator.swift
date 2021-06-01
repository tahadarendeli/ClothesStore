//
//  CatalogueViewCoordinator.swift
//  Clothes Store
//
//  Created by Mentor on 1.06.2021.
//  Copyright © 2021 RichieHope. All rights reserved.
//

import SwiftUI

final class CatalogueViewCoordinator: Coordinator {
    var navigationController: UINavigationController?
    var children: [Coordinator]? = nil
    
    func start() {
        var viewController: CoordinatingViewController = CatalogueViewHostingViewController(rootView: CatalogueView())
        viewController.coordinator = self
        
        navigationController?.setViewControllers([viewController], animated: false)
    }
}
