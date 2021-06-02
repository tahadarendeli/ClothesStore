//
//  BasketViewController.swift
//  Clothes Store
//
//  Created by Richard Hope on 01/05/2021.
//  Copyright © 2021 Deloitte. All rights reserved.
//

import UIKit

protocol BasketViewProtocol: AnyObject {
    func updateBasket()
    func updateCheckoutText(with text: String)
}

final class BasketViewController: UIViewController, BasketViewProtocol, Coordinating, Storyboarded {
    
    //Views
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var noProductsLabel: UILabel!
    @IBOutlet private var total: UILabel!
    @IBOutlet private var checkoutButton: UIButton!
    @IBOutlet private weak var checkoutView: UIView!
    
    //Variables
    var coordinator: Coordinator?
    var presenter: BasketPresentation!

    override func viewDidLoad() {
        super.viewDidLoad()

        checkoutButton.dropShadow(radius: 8, opacity: 0.4, color: UIColor.primaryColour)
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.getProducts()
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: Strings.Identifiers.basketCellNibName.rawValue, bundle: nil), forCellReuseIdentifier: Strings.Identifiers.basketCell.rawValue)
    }
    
    func updateBasket() {
        noProductsLabel.isHidden = !presenter.products.isEmpty
        checkoutView.isHidden = presenter.products.isEmpty
        tableView.separatorStyle = presenter.products.isEmpty ? .none : .singleLine
        
        tableView.reloadData()
    }
    
    func updateCheckoutText(with text: String) {
        total.text = text
    }
    
    @IBAction func checkoutTapped(_ sender: Any) {
        presenter.buy()
    }
}
