//
//  CatalogueViewController.swift
//  Clothes Store
//
//  Created by Richard Hope on 01/05/2021.
//  Copyright © 2021 Deloitte. All rights reserved.
//

import UIKit

protocol CatalogueViewProtocol: AnyObject {
    func updateProductList(products: [CatalogueProduct])
    func failedFetchProducts()
}

final class CatalogueViewController: UIViewController, CatalogueViewProtocol, Coordinating, Storyboarded {

    //Views
    @IBOutlet private var collectionView: UICollectionView!
    @IBOutlet private var activity: UIActivityIndicatorView!

    //Variables
    internal var products : [CatalogueProduct] = []
    
    var coordinator: Coordinator?
    var presenter: CataloguePresentation!

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(UINib(nibName: Strings.Identifiers.catalogueCellNibName.rawValue, bundle: nil), forCellWithReuseIdentifier: Strings.Identifiers.productCell.rawValue)
        presenter.fetchProducts()
    }
    
    func failedFetchProducts() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: Strings.Texts.error.rawValue, message: Strings.Texts.alertMessage.rawValue, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: Strings.Texts.retry.rawValue, style: .default, handler: { (action) in
                self.presenter.fetchProducts()
                alert.dismiss(animated: true, completion: nil)
            }))

            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func updateProductList(products: [CatalogueProduct]) {
        DispatchQueue.main.async {
            self.products = products
            self.activity.isHidden = true
            self.collectionView.reloadData()
        }
    }
}
