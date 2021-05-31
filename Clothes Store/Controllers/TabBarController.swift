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

    func setup(observer: inout AnyCancellable?, action: PassthroughSubject<Int, Never>, tabBarItem: UITabBarItem?) {
        observer = action.sink(receiveValue: setBadges(tabBarItem: tabBarItem))
    }
    
    private func setBadges(tabBarItem: UITabBarItem?) -> (Int) -> Void {
        return { count in
            tabBarItem?.badgeValue = count > 0 ? count.description : nil
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if let tabItems = tabBar.items {
            wishlistTabItem = tabItems[1]
            basketTabItem = tabItems[2]
        }
        
        setup(observer: &wishlistObserver, action: WishlistMemoryService.shared().action, tabBarItem: wishlistTabItem)
        setup(observer: &basketObserver, action: BasketMemoryService.shared().action, tabBarItem: basketTabItem)
    }
}
