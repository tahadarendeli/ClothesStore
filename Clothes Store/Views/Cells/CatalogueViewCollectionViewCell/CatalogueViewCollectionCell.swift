//
//  CatalogueViewCollectionCell.swift
//  Clothes Store
//
//  Created by Richard Hope on 01/05/2021.
//  Copyright © 2021 Deloitte. All rights reserved.
//

import UIKit

final class CatalogueViewCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var productName: UILabel!
    @IBOutlet private weak var productPrice: UILabel!
    @IBOutlet private weak var cellView: UIView!
    @IBOutlet private weak var wishListed: UIImageView!
    @IBOutlet private weak var productImage: UIImageView!
    
    func configureWithProduct(product: CatalogueProduct){
        let selectedProduct = product.0
        let didWishlisted = product.1
        
        self.productName.text = selectedProduct.name
        self.productPrice.text = CurrencyHelper.getMoneyString(selectedProduct.price ?? 0)
        self.cellView.dropShadow(radius: 10, opacity: 0.1, color: .black)
        let placeHolderImage = UIImage(named: Strings.Images.placeholder.rawValue)
        
        if let image = selectedProduct.image, let url = URL(string: image) {
            productImage.getImage(with: url)
        } else {
            productImage.image = placeHolderImage
        }
        wishListed.isHidden = !didWishlisted
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        productImage.cancelImageRequest()
        productImage.image = nil
    }
}


