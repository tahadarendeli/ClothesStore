//
//  CatalogueViewHostingViewController.swift
//  Clothes Store
//
//  Created by Mentor on 29.05.2021.
//  Copyright © 2021 RichieHope. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

final class CatalogueViewHostingViewController: UIHostingController<CatalogueView> {
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder, rootView: CatalogueView())
        
    }
}
