//
//  SavedViewTableViewCell.swift
//  Clothes Store
//
//  Created by Richard Hope on 01/05/2021.
//  Copyright © 2021 Deloitte. All rights reserved.
//

import UIKit

final class SavedViewTableViewCell: UITableViewCell{

    //Views
    @IBOutlet private var cellView: UIView!
    @IBOutlet private var productName: UILabel!
    @IBOutlet private var productPrice: UILabel!
    @IBOutlet private var addToButton: UIButton!

    //Variables
    weak var delegate : BuyCellButtonTapped?

    func configureWithProduct(product: Product){

        self.productName.text = product.name
        self.productPrice.text = CurrencyHelper.getMoneyString(product.price ?? 0)
        self.cellView.dropShadow(radius: 10, opacity: 0.1, color: .black)

    }

    @IBAction func addToBasket(_ sender: Any) {
        delegate?.addProductToBasket(self)
    }


}
