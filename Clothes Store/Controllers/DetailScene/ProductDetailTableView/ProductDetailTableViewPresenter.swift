//
//  ProductDetailTableViewPresenter.swift
//  Clothes Store
//
//  Created by Mentor on 3.06.2021.
//  Copyright © 2021 RichieHope. All rights reserved.
//

import UIKit

protocol ProductDetailTableViewPresentation {
    var product: ProductPresentable! { get }
    var bigSectionHeight: CGFloat { get }
    var smallSectionHeight: CGFloat { get }
    var numberOfRows: Int { get }
    
    func prepareViewModel()
}

final class ProductDetailTableViewPresenter: ProductDetailTableViewPresentation {
    weak var view: ProductDetailTableViewProtocol?
    
    var product: ProductPresentable!
    
    var bigSectionHeight: CGFloat {
        return 275
    }
    
    var smallSectionHeight: CGFloat {
        return 75
    }
    
    var numberOfRows: Int {
        return 4
    }
    
    init(with view: ProductDetailTableViewProtocol, product: ProductPresentable) {
        self.view = view
        self.product = product
    }
    
    
    func prepareViewModel() {
        var viewModel = ProductDetailTableViewModel()
        viewModel.productName = product?.name
        viewModel.productPresentablePrice = product?.presentablePrice
        
        let attributedString = NSMutableAttributedString(string: product?.presentableOldPrice ?? "")
        attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSNumber(value: NSUnderlineStyle.single.rawValue), range: NSMakeRange(0, attributedString.length))
        attributedString.addAttribute(NSAttributedString.Key.strikethroughColor, value: UIColor.primaryColour, range: NSMakeRange(0, attributedString.length))
        
        if product?.oldPrice != nil{
            viewModel.productOldPrice = attributedString
        }
        
        viewModel.productCategory = product?.category?.rawValue
        viewModel.productStockCount = "\(product?.stock ?? 0)"
        if (product?.stock ?? 0) > 0 {
            viewModel.productInStockText = Strings.Texts.inStock.rawValue
        }else{
            viewModel.productInStockText = Strings.Texts.outStock.rawValue
        }
        
        viewModel.productPlaceholderImage = UIImage(named: Strings.Images.placeholder.rawValue)
        
        if let image = product?.image, let url = URL(string: image) {
            viewModel.productImageUrl = url
        }
        
        view?.configureViews(with: viewModel)
    }
}
