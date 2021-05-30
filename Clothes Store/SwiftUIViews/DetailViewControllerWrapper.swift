//
//  DetailViewControllerWrapper.swift
//  Clothes Store
//
//  Created by Mentor on 30.05.2021.
//  Copyright © 2021 RichieHope. All rights reserved.
//

import SwiftUI

struct DetailViewControllerWrapper: UIViewControllerRepresentable {
    
    let product: Product
    
    func makeUIViewController(context: Context) -> UINavigationController {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: Strings.Identifiers.detailContainer.rawValue) as DetailViewContainerViewController
        let navigationController = UINavigationController(rootViewController: viewController)
        
        viewController.product = product
        
        return navigationController
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
    }
}
