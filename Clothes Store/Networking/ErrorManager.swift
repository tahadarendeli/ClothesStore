//
//  ErrorManager.swift
//  Clothes Store
//
//  Created by Mentor on 1.06.2021.
//  Copyright © 2021 RichieHope. All rights reserved.
//

import Foundation

enum ErrorManager: LocalizedError {
    case invalidURL, parseJSON, unknown
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return Strings.Errors.invalidURL.rawValue
        case .parseJSON:
            return Strings.Errors.parseJSON.rawValue
        case .unknown:
            return Strings.Errors.unknown.rawValue
        }
    }
}
