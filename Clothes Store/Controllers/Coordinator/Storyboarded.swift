//
//  Storyboarded.swift
//  Clothes Store
//
//  Created by Mentor on 1.06.2021.
//  Copyright © 2021 RichieHope. All rights reserved.
//

import UIKit

protocol Storyboarded {
    static func instantiate(with storyboardName: String) -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate(with storyboardName: String) -> Self {
        
        let fullName = NSStringFromClass(self)
        let className = fullName.components(separatedBy: ".")[1]
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)

        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }
}
