//
//  Model.swift
//  FakeStore
//
//  Created by Roman on 15/10/2024.
//

import Foundation

// MARK: - Product
struct Product: Codable, Identifiable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: String?
    let rating: Rating
}

//struct Category: Codable {
//    let electronics: String
//    let jewelery: String
//    let menSClothing: String
//    let womenSClothing: String
//}

// MARK: - Rating
struct Rating: Codable {
    let rate: Double
    let count: Int
}
