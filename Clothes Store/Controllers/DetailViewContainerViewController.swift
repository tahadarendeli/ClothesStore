//
//  DetailViewContainerViewController.swift
//  Clothes Store
//
//  Created by Richard Hope on 01/05/2021.
//  Copyright © 2021 Deloitte. All rights reserved.
//

import UIKit

final class DetailViewContainerViewController: UIViewController{
    
    //Views
    private var backButton : UIBarButtonItem!
    @IBOutlet private var wishListButton: UIButton!
    @IBOutlet private var addToCartButton: UIButton!
    @IBOutlet private var addedToWishlistLabel: UILabel!
    @IBOutlet private var addedToBasketLabel: UILabel!

    //Variables
    var product : Product!
    
    private var basketMemoryService: BasketMemoryService {
        return BasketMemoryService.shared()
    }
    
    private var wishlistMemoryService: WishlistMemoryService {
        return WishlistMemoryService.shared()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpButtons()
    }
    
    private func setUpButtons(){
        wishListButton.dropShadow(radius: 8, opacity: 0.2, color: .black)
        addToCartButton.dropShadow(radius: 8, opacity: 0.4, color: UIColor.primaryColour)
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Strings.Identifiers.detailContainer.rawValue {
            let dest = segue.destination as! ProductDetailTableViewController
            dest.product = product
        }
    }


    // MARK: - Actions
    @IBAction private func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction private func addToCartAction(_ sender: Any) {
        Haptic.feedBack()
        
        basketMemoryService.add(product: product)
    }

    @IBAction private func addToWishListAction(_ sender: Any) {
        Haptic.feedBack()
        
        wishlistMemoryService.add(product: product)
    }
}
