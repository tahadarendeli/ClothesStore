//
//  TabBarController.swift
//  Clothes Store
//
//  Created by Richard Hope on 01/05/2021.
//  Copyright © 2021 Deloitte. All rights reserved.
//
import UIKit
import Combine

final class TabBarController: UITabBarController, Coordinating, Storyboarded {

    //Views
    private var catalogueTabItem: UITabBarItem? {
        didSet {
            catalogueTabItem?.title = "CATALOGUE"
            catalogueTabItem?.image = UIImage(systemName: "doc.text.magnifyingglass")
            catalogueTabItem?.image?.withTintColor(.primaryColour)
        }
    }
    private var wishlistTabItem: UITabBarItem? {
        didSet {
            wishlistTabItem?.title = "WISHLIST"
            wishlistTabItem?.image = UIImage(systemName: "arrow.down.heart.fill")
            wishlistTabItem?.image?.withTintColor(.primaryColour)
        }
    }
    private var basketTabItem: UITabBarItem? {
        didSet {
            basketTabItem?.title = "BASKET"
            basketTabItem?.image = UIImage(systemName: "cart")
            basketTabItem?.image?.withTintColor(.primaryColour)
        }
    }
    
    //Observers
    private var wishlistObserver: AnyCancellable?
    private var basketObserver: AnyCancellable?
    
    var coordinator: Coordinator?

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
        navigationController?.setNavigationBarHidden(true, animated: false)

        if let tabItems = tabBar.items {
            catalogueTabItem = tabItems[0]
            wishlistTabItem = tabItems[1]
            basketTabItem = tabItems[2]
        }
        
        setup(observer: &wishlistObserver, action: WishlistMemoryService.shared().action, tabBarItem: wishlistTabItem)
        setup(observer: &basketObserver, action: BasketMemoryService.shared().action, tabBarItem: basketTabItem)
    }
}
