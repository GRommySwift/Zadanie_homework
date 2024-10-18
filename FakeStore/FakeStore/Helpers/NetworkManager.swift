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
    
    func fetchCategories() -> Promise<[String]> {
        return Promise { seal in
            guard let url = URLConstant.categories.url else {
                seal.reject(NetworkError.invalidURL)
                return
            }
            AF.request(url)
                .validate()
                .responseDecodable(of: [String].self) { response in
                    switch response.result {
                    case .success(let categories):
                        seal.fulfill(categories)
                    case .failure(let error):
                        seal.reject(NetworkError.networkError(error))
                    }
                }
        }
    }
    
    func fetchProducts() -> Promise<[Product]> {
        return Promise { seal in
            guard let url = URLConstant.products.url else {
                seal.reject(NetworkError.invalidURL)
                return
            }
            AF.request(url)
                .validate()
                .responseDecodable(of: [Product].self) { response in
                    switch response.result {
                    case .success(let products):
                        seal.fulfill(products)
                    case .failure(let error):
                        seal.reject(NetworkError.networkError(error))
                    }
                }
        }
    }
    
    func fetchProduct(id: Int) -> Promise<Product> {
        return Promise { seal in
            guard let url = URLConstant.productById(id: id).url else {
                seal.reject(NetworkError.invalidURL)
                return
            }
            AF.request(url)
                .validate()
                .responseDecodable(of: Product.self) { response in
                    switch response.result {
                    case .success(let product):
                        seal.fulfill(product)
                    case .failure(let error):
                        seal.reject(NetworkError.networkError(error))
                    }
                }
        }
    }
    
    func fetchProductsByCategory(category: String?) -> Promise<[Product]> {
        return Promise { seal in
            guard let selectedCategory = category, let url = URLConstant.productByCategory(category: selectedCategory).url else {
                seal.reject(NetworkError.invalidURL)
                return
            }
            AF.request(url)
                .validate()
                .responseDecodable(of: [Product].self) { response in
                    switch response.result {
                    case .success(let products):
                        seal.fulfill(products)
                    case .failure(let error):
                        seal.reject(NetworkError.networkError(error))
                    }
                }
        }
    }
}
