//
//  FakeStoreViewModel.swift
//  FakeStore
//
//  Created by Roman on 16/10/2024.
//

import Foundation
import PromiseKit

class FakeStoreViewModel: ObservableObject {
    
    @Published var products: [Product] = []
    @Published var productById: Product?
    @Published var categories: [String] = []
    @Published var selectedCategory: String? = nil
    @Published var isLoaded: Bool = false
    @Published var errorMessage: String? = nil
    
    init() {
        fetchCategories()
        fetchProducts()
    }
    
    func fetchCategories() {
        NetworkManager.shared.fetchCategories()
                .done { [weak self] categories in
                    self?.categories = categories
                }
                .catch { [weak self] error in
                    self?.errorMessage = error.localizedDescription
                }
        }
    
    func fetchProducts() {
        isLoaded = false
        errorMessage = nil
        
        if selectedCategory == nil {
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
        } else {
            NetworkManager.shared.fetchProductsByCategory(category: selectedCategory)
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
    
    func applyFilter(_ category: String) {
        selectedCategory = category
        fetchProducts()
        categories = categories.filter { $0 != category }
        categories.insert(category, at: 0)
    }
    
    func resetFilter() {
        selectedCategory = nil
        categories = []
        fetchCategories()
        fetchProducts()
    }
}
