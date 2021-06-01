//
//  WishlistViewController.swift
//  Clothes Store
//
//  Created by Richard Hope on 01/05/2021.
//  Copyright © 2021 Deloitte. All rights reserved.
//

import UIKit

protocol WishlistViewProtocol: AnyObject {
    func updateWishlist(with products: [Product])
}

protocol BuyCellButtonTapped: class {
    func addProductToBasket(_ sender: SavedViewTableViewCell)
}

final class WishlistViewController: UIViewController, BuyCellButtonTapped, WishlistViewProtocol {

    //Views
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var noProductsLabel: UILabel!

    //Variable
    internal lazy var presenter: WishlistPresentation = WishlistPresenter(with: self)
    internal var products: [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.getProducts()
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: Strings.Identifiers.wishlistCellNibName.rawValue, bundle: nil), forCellReuseIdentifier: Strings.Identifiers.wishlistCell.rawValue)
    }
    
    func updateWishlist(with products: [Product]) {
        self.products = products
        
        noProductsLabel.isHidden = !products.isEmpty
        tableView.separatorStyle = products.isEmpty ? .none : .singleLine
        
        tableView.reloadData()
    }

    // MARK: - Actions
    func addProductToBasket(_ sender: SavedViewTableViewCell) {
        Haptic.feedBack()
        
        guard let indexPath = tableView.indexPath(for: sender) else {
            return
        }
        
        presenter.addProductToBasket(product: products[indexPath.row])
    }
}
