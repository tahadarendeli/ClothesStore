//
//  BasketViewController.swift
//  Clothes Store
//
//  Created by Richard Hope on 01/05/2021.
//  Copyright © 2021 Deloitte. All rights reserved.
//

import UIKit


class BasketViewController: UIViewController {
    
    //Views
    @IBOutlet var tableView: UITableView!
    @IBOutlet var noProductsLabel: UILabel!
    @IBOutlet var total: UILabel!
    @IBOutlet var checkoutButton: UIButton!
    
    //Variables
    private var basketMemoryService: BasketMemoryService {
        return BasketMemoryService.shared()
    }
    private var products: [Product] {
        return basketMemoryService.get()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        checkoutButton.dropShadow(radius: 8, opacity: 0.4, color: UIColor.primaryColour)
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureViews()
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func configureViews() {
        tableView.reloadData()
        noProductsLabel.isHidden = !products.isEmpty
        
        
        total.text = CurrencyHelper.getMoneyString(calculateTotalPrice())
    }
    
    private func calculateTotalPrice() -> Float {
        
        var totalPrice: Float = 0.0
        
        products.forEach({
            if let price = $0.price,
               let quantity = $0.stock {
                totalPrice = totalPrice + price * Float(quantity)
            }
        })
        
        return totalPrice
    }
}

extension BasketViewController: UITableViewDelegate{

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)

    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let deleteAction = UIContextualAction.init(style:.destructive, title: Strings.Texts.remove.rawValue, handler: { [weak self] (action, view, completion) in
            guard let self = self else { return }
            
            Haptic.feedBack()
            
            self.basketMemoryService.remove(product: self.products[indexPath.row])
            self.configureViews()
        })

        deleteAction.backgroundColor = UIColor.primaryColour

        let config = UISwipeActionsConfiguration(actions: [deleteAction])
        config.performsFirstActionWithFullSwipe = true
        return config

    }
}

extension BasketViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Strings.Identifiers.basketCell.rawValue, for: indexPath) as? BasketViewTableViewCell {
            cell.configureWithProduct(product: products[indexPath.row])
            
            return cell
        }
        
        return UITableViewCell()
    }
}

