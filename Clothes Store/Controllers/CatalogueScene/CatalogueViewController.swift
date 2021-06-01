//
//  CatalogueViewController.swift
//  Clothes Store
//
//  Created by Richard Hope on 01/05/2021.
//  Copyright © 2021 Deloitte. All rights reserved.
//

import UIKit
import Combine

protocol CatalogueViewProtocol: AnyObject {
    func updateProductList(products: [Product])
    func failedFetchProducts()
}

final class CatalogueViewController: UIViewController, CatalogueViewProtocol {

    //Views
    @IBOutlet private var collectionView: UICollectionView!
    @IBOutlet private var activity: UIActivityIndicatorView!

    //Variables
    private var observer: AnyCancellable?
    internal var products : [Product] = []
    
    private lazy var presenter: CataloguePresentation = CataloguePresenter(with: self)

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(UINib(nibName: Strings.Identifiers.catalogueCellNibName.rawValue, bundle: nil), forCellWithReuseIdentifier: Strings.Identifiers.productCell.rawValue)
        presenter.fetchProducts()
        observer = WishlistMemoryService.shared().action.sink(receiveValue: { [weak self] product in
            self?.presenter.getProducts()
        })
    }
    
    func failedFetchProducts() {
        let alert = UIAlertController(title: Strings.Texts.error.rawValue, message: Strings.Texts.alertMessage.rawValue, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Strings.Texts.retry.rawValue, style: .default, handler: { (action) in
            self.presenter.getProducts()
            alert.dismiss(animated: true, completion: nil)
        }))

        self.present(alert, animated: true, completion: nil)
    }
    
    func updateProductList(products: [Product]) {
        DispatchQueue.main.async {
            self.products = products
            self.activity.isHidden = true
            self.collectionView.reloadData()
        }
    }
}
