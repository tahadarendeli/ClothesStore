//
//  DetailViewContainerViewController.swift
//  Clothes Store
//
//  Created by Richard Hope on 01/05/2021.
//  Copyright © 2021 Deloitte. All rights reserved.
//

import UIKit

protocol DetailViewProtocol: AnyObject {
}

final class DetailViewContainerViewController: UIViewController, DetailViewProtocol, Storyboarded {
    
    //Views
    private var backButton : UIBarButtonItem!
    @IBOutlet private weak var wishListButton: UIButton!
    @IBOutlet private weak var addToCartButton: UIButton!
    @IBOutlet private weak var addedToWishlistLabel: UILabel!
    @IBOutlet private weak var addedToBasketLabel: UILabel!

    //Variables
    var presenter: DetailPresentation!
    var coordinator: Coordinator?

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpButtons()
    }
    
    private func setUpButtons(){
        let radius: CGFloat = 8
        wishListButton.dropShadow(radius: radius, opacity: 0.2, color: .black)
        addToCartButton.dropShadow(radius: radius, opacity: 0.4, color: .primaryColour)
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Strings.Identifiers.detailContainer.rawValue {
            if let destination = segue.destination as? ProductDetailTableViewController {
                destination.presenter = ProductDetailTableViewPresenter(with: destination, product: presenter.product)
            }
        }
    }


    // MARK: - Actions
    @IBAction private func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction private func addToCartAction(_ sender: Any) {
        Haptic.feedBack()
        
        presenter.addProductToBasket()
    }

    @IBAction private func addToWishListAction(_ sender: Any) {
        Haptic.feedBack()
        
        presenter.addProductToWishlist()
    }
}
