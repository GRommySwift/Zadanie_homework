//
//  URLConstant.swift
//  FakeStore
//
//  Created by Roman on 16/10/2024.
//

import Foundation

enum URLConstant {
    
    static let baseURL = "https://fakestoreapi.com"
    
    case categories
    case products
    case productById(id: Int)
    case productByCategory(category: String)
}

extension URLConstant {
    var url: URL? {
        switch self {
        case .products:
            return URL(string: "\(URLConstant.baseURL)/products")
        case .productById(let id):
            return URL(string: "\(URLConstant.baseURL)/products/\(id)")
        case .productByCategory(let category):
            return URL(string: "\(URLConstant.baseURL)/products/category/\(category)")
        case .categories:
            return URL(string: "\(URLConstant.baseURL)/products/categories/")
        }
    }
}
