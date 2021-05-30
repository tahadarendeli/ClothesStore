//
//  TabBarController.swift
//  Clothes Store
//
//  Created by Richard Hope on 01/05/2021.
//  Copyright © 2021 Deloitte. All rights reserved.
//
import UIKit
import Combine

final class TabBarController: UITabBarController {

    //Views
    private var wishlistTabItem: UITabBarItem?
    private var basketTabItem: UITabBarItem?
    
    //Observers
    private var wishlistObserver: AnyCancellable?
    private var basketObserver: AnyCancellable?

    //Variables
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setWishlistOberserver()
        setBasketObserver()
    }
    
    private func setWishlistOberserver() {
        wishlistObserver = WishlistMemoryService.shared().action.sink(receiveValue: { [weak self] count in
            guard let self = self else { return }
            
            self.wishlistTabItem?.badgeValue = count > 0 ? count.description : nil
        })
    }
    
    private func setBasketObserver() {
        basketObserver = BasketMemoryService.shared().action.sink(receiveValue: { [weak self] count in
            guard let self = self else { return }
            
            self.basketTabItem?.badgeValue = count > 0 ? count.description : nil
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if let tabItems = tabBar.items {
            wishlistTabItem = tabItems[1]
            basketTabItem = tabItems[2]
        }
    }
}
