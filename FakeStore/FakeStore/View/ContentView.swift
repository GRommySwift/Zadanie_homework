//
//  ContentView.swift
//  FakeStore
//
//  Created by Roman on 15/10/2024.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = FakeStoreViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.products, id: \.id) { product in
                NavigationLink(destination: DetailView(productID: product.id, viewModel: viewModel), label: {
                    HStack(spacing: 10) {
                        AsyncImageLoader(product: product, widthOfImage: 73, heightOfImage: 73)
                        VStack(alignment: .leading) {
                            Text(product.title)
                            Text(product.category)
                                .foregroundStyle(.gray)
                        }
                    }
                })
            }
            .listStyle(.plain)
        }
    }
}

#Preview {
    ContentView()
}
