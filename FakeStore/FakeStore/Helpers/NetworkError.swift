//
//  NetworkError.swift
//  FakeStore
//
//  Created by Roman on 18/10/2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case networkError(Error)
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid url"
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        }
    }
}