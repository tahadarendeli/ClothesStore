//
//  WishlistCoordinator.swift
//  Clothes Store
//
//  Created by Mentor on 1.06.2021.
//  Copyright © 2021 RichieHope. All rights reserved.
//

import UIKit

final class WishlistCoordinator: Coordinator {
    var navigationController: UINavigationController?
    var children: [Coordinator]? = nil
    
    func start() {
        var viewController: CoordinatingViewController = WishlistViewController.instantiate(with: Strings.Identifiers.Storyboard.wishlist.rawValue)
        viewController.coordinator = self
        
        navigationController?.setViewControllers([viewController], animated: false)
    }
}
