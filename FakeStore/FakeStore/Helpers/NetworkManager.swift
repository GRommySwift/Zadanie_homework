//
//  NetworkManager.swift
//  FakeStore
//
//  Created by Roman on 15/10/2024.
//

import Foundation
import Alamofire
import PromiseKit

final class NetworkManager {
    
    static var shared = NetworkManager()
    private init() {}
    
    func fetchProducts() -> Promise<[Product]> {
        return Promise { product in
            AF.request(URLConstants.baseURL)
                .validate()
                .responseDecodable(of: [Product].self) { response in
                    switch response.result {
                    case .success(let products):
                        product.fulfill(products)
                    case .failure(let error):
                        product.reject(error)
                    }
                }
        }
    }
    
    func fetchProduct(id: Int) -> Promise<Product> {
        let productByIdURL = "\(URLConstants.baseURL)/\(id)"
        return Promise { product in
            AF.request(productByIdURL)
                .validate()
                .responseDecodable(of: Product.self) { response in
                    switch response.result {
                    case .success(let products):
                        product.fulfill(products)
                    case .failure(let error):
                        product.reject(error)
                    }
                }
        }
    }
}
