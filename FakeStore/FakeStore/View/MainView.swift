//
//  ContentView.swift
//  FakeStore
//
//  Created by Roman on 15/10/2024.
//

import SwiftUI

struct MainView: View {
    
    @StateObject private var viewModel = FakeStoreViewModel()
    @State private var showPicker = false
    private let productNavTitle = "Produkty"
    private let clearFilterText = "Zrušiť filter"
    private let buttonText = "Filter"
    private let imageSize: CGFloat = 73
    
    var body: some View {
        NavigationView {
            List(viewModel.products, id: \.id) { product in
                NavigationLink(destination: DetailView(productID: product.id, viewModel: viewModel)) {
                    HStack(spacing: .ten) {
                        AsyncImageLoader(product: product, widthOfImage: imageSize, heightOfImage: imageSize)
                        VStack(alignment: .leading) {
                            Text(product.title)
                                .foregroundStyle(.black)
                            Text(product.category)
                                .foregroundStyle(.gray)
                        }
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle(viewModel.selectedCategory ?? productNavTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button(buttonText) {
                    showPicker.toggle()
                }
            }
            .confirmationDialog(showPicker: $showPicker, viewModel: viewModel, clearFilterText: clearFilterText)
        }
    }
}

#Preview {
    MainView()
}
