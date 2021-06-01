//
//  ProductDetailTableViewController.swift
//  Clothes Store
//
//  Created by Richard Hope on 01/05/2021.
//  Copyright © 2021 Deloitte. All rights reserved.
//

import UIKit

final class ProductDetailTableViewController: UITableViewController {

    //Views
    @IBOutlet private var productPrice: UILabel!
    @IBOutlet private var productOldPrice: UILabel!
    @IBOutlet private var productInStock: UILabel!
    @IBOutlet private var productName: UILabel!
    @IBOutlet private var productCategory: UILabel!
    @IBOutlet private var productStockCount: UILabel!
    @IBOutlet private weak var productImageView: UIImageView!
    
    //Variables
    var product : Product?
    private var productImage : UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViews()
    }
    
    private func configureViews() {
        productName.text = product?.name
        productPrice.text = CurrencyHelper.getMoneyString(product?.price ?? 0)

        let attributedString = NSMutableAttributedString(string: CurrencyHelper.getMoneyString(product?.oldPrice ?? 0))
        attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSNumber(value: NSUnderlineStyle.single.rawValue), range: NSMakeRange(0, attributedString.length))
        attributedString.addAttribute(NSAttributedString.Key.strikethroughColor, value: UIColor.primaryColour, range: NSMakeRange(0, attributedString.length))

        if product?.oldPrice != nil{
        productOldPrice.attributedText = attributedString
        }

        productCategory.text = product?.category?.rawValue
        productStockCount.text = "\(product?.stock ?? 0)"
        if (product?.stock ?? 0) > 0 {
            productInStock.text = Strings.Texts.inStock.rawValue
        }else{
            productInStock.text = Strings.Texts.outStock.rawValue
        }
        
        let placeHolderImage = UIImage(named: Strings.Images.placeholder.rawValue)
        
        if let image = product?.image, let url = URL(string: image) {
            productImageView.getImage(with: url, completion: nil)
        } else {
            productImageView.image = placeHolderImage
        }
    }

    // MARK: - Table view data source & delegates

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 4
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row {
        case 0:
            return 275
        default:
            return 75
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
