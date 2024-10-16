//
//  FakeStoreViewModel.swift
//  FakeStore
//
//  Created by Roman on 16/10/2024.
//

import Foundation

class FakeStoreViewModel: ObservableObject {
    
    @Published var products: [Product] = []
    @Published var productById: Product?
    @Published var isLoaded: Bool = false
    @Published var errorMessage: String? = nil
    
    init() {
        fetchProducts()
    }
    
    func fetchProducts() {
        isLoaded = false
        errorMessage = nil
        NetworkManager.shared.fetchProducts()
            .done { [weak self] products in
                self?.products = products
            }
            .catch { [weak self] error in
                self?.errorMessage = error.localizedDescription
            }
            .finally { [weak self] in
                self?.isLoaded = true
            }
    }
    
    func fetchProductByID(id: Int) {
        isLoaded = false
        errorMessage = nil
        NetworkManager.shared.fetchProduct(id: id)
            .done { [weak self] product in
                self?.productById = product
                self?.isLoaded = true
            }
            .catch { [weak self] error in
                self?.errorMessage = error.localizedDescription
            }
            .finally { [weak self] in
                self?.isLoaded = true
            }
    }
}
