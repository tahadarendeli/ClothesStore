//
//  CatalogueViewController.swift
//  Clothes Store
//
//  Created by Richard Hope on 01/05/2021.
//  Copyright © 2021 Deloitte. All rights reserved.
//

import UIKit

class CatalogueViewController: UIViewController {

    //Views
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var activity: UIActivityIndicatorView!

    //Variables
    var products : [Product] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        getProducts()
    }

    func getProducts(){

        ProductsDataService.getProducts { (products, error) in
            if error != nil{
                let alert = UIAlertController(title: Strings.Texts.error.rawValue, message: Strings.Texts.alertMessage.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: Strings.Texts.retry.rawValue, style: .default, handler: { (action) in
                    self.getProducts()
                    alert.dismiss(animated: true, completion: nil)
                }))

                self.present(alert, animated: true, completion: nil)
            }else{

                self.products = products?.products ?? []
                self.activity.isHidden = true
                self.collectionView.reloadData()
            }
        }
    }
}

extension CatalogueViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Strings.Identifiers.productCell.rawValue, for: indexPath) as! CatalogueViewCollectionViewCell
        
        let product = products[indexPath.row]
        cell.configureWithProduct(product: product)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
        return CGSize(width: itemSize, height: 250)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let product = products[indexPath.row]

        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: Strings.Identifiers.detailContainer.rawValue) as! DetailViewContainerViewController
        let navigationVC = UINavigationController(rootViewController: detailVC)
        detailVC.product = product
        Haptic.feedBack()
        self.present(navigationVC, animated: true, completion: nil)
    }

}

