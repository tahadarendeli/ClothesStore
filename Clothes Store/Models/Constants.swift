//
//  Constants.swift
//  Clothes Store
//
//  Created by Richard Hope on 01/05/2021.
//  Copyright © 2021 Deloitte. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

enum URLCall : String {
    case catalogue = "https://api.npoint.io/0f78766a6d68832d309d"
}

enum Strings {
    
    enum Identifiers: String {
        case detailContainer = "detailContainer"
        case productCell = "productCell"
        case basketCell = "basketCell"
        case wishlistCell = "savedCell"
        case basketCellNibName = "BasketViewTableViewCell"
        case wishlistCellNibName = "SavedViewTableViewCell"
        case catalogueCellNibName = "CatalogueViewCollectionViewCell"
    }
    
    enum Images: String {
        case placeholder = "placeholderImage"
        case wishlisted = "heart.fill"
    }
    
    enum Texts: String {
        case error = "Error"
        case alertMessage = "There has been an error getting the data. Please check your network connection and try again"
        case retry = "Retry"
        case remove = "Remove"
        case inStock = "In Stock"
        case outStock = "Out of Stock"
        case ok = "OK"
        case quantity = "Qty"
        case catalogueTitle = "Catalogue"
    }
    
    enum Errors: String {
        case invalidURL = "Invalid URL"
        case parseJSON = "JSON Parse Failed"
        case unknown = "Unknown Error"
    }
}

extension Font {
    public static func light(size: CGFloat = 14) -> Font {
        return Font.custom("HelveticaNeue-Light", size: size)
    }
    
    public static func bold(size: CGFloat = 18) -> Font {
        return Font.custom("HelveticaNeue-Bold", size: size)
    }
}

extension UIColor{

    class var primaryColour: UIColor{
        return #colorLiteral(red: 1, green: 0.3348520994, blue: 0.4051724672, alpha: 1)
    }
    
    class var backgroundColour: UIColor {
        return UIColor(red: 242/255.0, green: 242/255.0, blue: 242/255.0, alpha: 1.0)
    }
}
