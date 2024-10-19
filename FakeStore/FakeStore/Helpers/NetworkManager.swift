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
    private let decoder = JSONDecoder()
    private init() {}
    
    //MARK: Async method to get from API with URLSession
    
    func fetchCategories() async throws -> [String] {
        guard let url = URLConstant.categories.url else {
            throw NetworkError.invalidURL
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw NetworkError.invalidResponse }
        do {
            return try decoder.decode([String].self, from: data)
        } catch {
            throw NetworkError.invalidData
        }
    }
    
    //MARK: Async method to get from API with Alamofire
    
    func fetchProducts() async throws -> [Product] {
        guard let url = URLConstant.products.url else {
            throw NetworkError.invalidURL
        }
        let dataResponse = try await AF.request(url)
            .validate()
            .serializingDecodable([Product].self).value
        
        return dataResponse
    }
    
    //MARK: Getting data with Alamofire / PromiseKit
    
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
