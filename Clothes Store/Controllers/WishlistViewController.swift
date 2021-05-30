//
//  WishlistViewController.swift
//  Clothes Store
//
//  Created by Richard Hope on 01/05/2021.
//  Copyright © 2021 Deloitte. All rights reserved.
//

import UIKit


protocol BuyCellButtonTapped: class {
    func addProductToBasket(_ sender: SavedViewTableViewCell)
}

final class WishlistViewController: UIViewController, BuyCellButtonTapped {

    //Views
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var noProductsLabel: UILabel!

    //Variables
    private var basketMemoryService: BasketMemoryService {
        return BasketMemoryService.shared()
    }
    
    private var wishlistMemoryService: WishlistMemoryService {
        return WishlistMemoryService.shared()
    }
    
    private var products: [Product] {
        return wishlistMemoryService.get()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reloadViews()
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func reloadViews() {
        tableView.reloadData()
        noProductsLabel.isHidden = !products.isEmpty
        tableView.separatorStyle = products.isEmpty ? .none : .singleLine
    }

    // MARK: - Actions
    func addProductToBasket(_ sender: SavedViewTableViewCell) {
        Haptic.feedBack()
        
        guard let indexPath = tableView.indexPath(for: sender) else {
            return
        }
        
        let product = products[indexPath.row]
        
        basketMemoryService.add(product: product)
        wishlistMemoryService.remove(product: product)
        
        reloadViews()
    }
}

extension WishlistViewController: UITableViewDelegate{

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let deleteAction = UIContextualAction.init(style:.destructive, title:  Strings.Texts.remove.rawValue, handler: { [weak self] (action, view, completion) in
            guard let self = self else { return }
            
            Haptic.feedBack()
          
            self.wishlistMemoryService.remove(product: self.products[indexPath.row])
            self.reloadViews()
        })

        deleteAction.backgroundColor = UIColor.primaryColour

        let config = UISwipeActionsConfiguration(actions: [deleteAction])
        config.performsFirstActionWithFullSwipe = true
        return config

    }
}

extension WishlistViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Strings.Identifiers.wishlistCell.rawValue, for: indexPath) as? SavedViewTableViewCell {
            cell.configureWithProduct(product: products[indexPath.row])
            cell.delegate = self
            
            return cell
        }
        
        return UITableViewCell()
    }
}



