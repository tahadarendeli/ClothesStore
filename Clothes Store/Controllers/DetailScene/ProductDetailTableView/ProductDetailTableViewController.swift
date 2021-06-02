//
//  ProductDetailTableViewController.swift
//  Clothes Store
//
//  Created by Richard Hope on 01/05/2021.
//  Copyright © 2021 Deloitte. All rights reserved.
//

import UIKit

protocol ProductDetailTableViewProtocol: AnyObject {
    func configureViews(with viewModel: ProductDetailTableViewModel?)
}

final class ProductDetailTableViewController: UITableViewController, ProductDetailTableViewProtocol {

    //Views
    @IBOutlet private weak var productPrice: UILabel!
    @IBOutlet private weak var productOldPrice: UILabel!
    @IBOutlet private weak var productInStock: UILabel!
    @IBOutlet private weak var productName: UILabel!
    @IBOutlet private weak var productCategory: UILabel!
    @IBOutlet private weak var productStockCount: UILabel!
    @IBOutlet private weak var productImageView: UIImageView!
    
    //Variables
    var presenter: ProductDetailTableViewPresentation!
    private var productImage : UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.prepareViewModel()
    }
    
    func configureViews(with viewModel: ProductDetailTableViewModel?) {
        productName.text = viewModel?.productName
        productPrice.text = viewModel?.productPresentablePrice
        productOldPrice.attributedText = viewModel?.productOldPrice
        productCategory.text = viewModel?.productCategory
        productStockCount.text = viewModel?.productStockCount
        productInStock.text = viewModel?.productInStockText
        productImageView.image = viewModel?.productPlaceholderImage
        
        if let url = viewModel?.productImageUrl {
            productImageView.getImage(with: url)
        }
    }

    // MARK: - Table view data source & delegates

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfRows
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row {
        case 0:
            return presenter.bigSectionHeight
        default:
            return presenter.smallSectionHeight
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
