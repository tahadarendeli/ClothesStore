//
//  ProductDetailTableViewModel.swift
//  Clothes Store
//
//  Created by Mentor on 3.06.2021.
//  Copyright © 2021 RichieHope. All rights reserved.
//

import UIKit

struct ProductDetailTableViewModel {
    var productName: String?
    var productPresentablePrice: String?
    var productOldPrice:  NSAttributedString?
    var productCategory: String?
    var productStockCount: String?
    var productInStockText: String?
    var productImageUrl: URL?
    var productPlaceholderImage: UIImage?
}
