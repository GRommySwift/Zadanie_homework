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
    
    private let baseURL = "https://fakestoreapi.com/products"
    
    func fetchProducts() -> Promise<[WelcomeElement]> {
        return Promise { product in
            AF.request(baseURL)
                .validate()
                .responseDecodable(of: [WelcomeElement].self) { response in
                    //
                }
        }
    }
}
