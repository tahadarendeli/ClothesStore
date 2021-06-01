//
//  BaseServiceManager.swift
//  Clothes Store
//
//  Created by Mentor on 1.06.2021.
//  Copyright © 2021 RichieHope. All rights reserved.
//

open class BaseServiceManager {
    static let service: ServiceManagerProvidable = {
       return ServiceManager()
    }()
}
