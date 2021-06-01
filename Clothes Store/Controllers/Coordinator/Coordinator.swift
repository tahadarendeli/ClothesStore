//
//  Coordinator.swift
//  Clothes Store
//
//  Created by Mentor on 1.06.2021.
//  Copyright © 2021 RichieHope. All rights reserved.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController? { get set }
    var children: [Coordinator]? { get set }
    
    init()
    
    func start()
}

protocol Coordinating {
    var coordinator: Coordinator? { get set }
}
