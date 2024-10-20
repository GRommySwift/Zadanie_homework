//
//  FakeStoreView.swift
//  FakeStore
//
//  Created by Roman on 15/10/2024.
//

import SwiftUI

struct FakeStoreView: View {
    
    @StateObject private var viewModel = FakeStoreViewModel()
    @State private var showPicker = false
    private let productNavTitle = "Produkty"
    private let clearFilterText = "Zrušiť filter"
    private let buttonText = "Filter"
    private let imageSize: CGFloat = 73
    
    var body: some View {
        NavigationView {
            List(viewModel.products, id: \.id) { product in
                productView(product)
            }
            .listStyle(.plain)
            .navigationTitle(viewModel.selectedCategory ?? productNavTitle)
            .navigationBarTitleDisplayMode(.inline)
            .backgroundNavigation(viewModel)
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
    FakeStoreView()
}

//MARK: View components

extension FakeStoreView {
    func productView(_ product: Product) -> some View {
        Button(action: {
            viewModel.selectedProduct(productID: product.id)
        }) {
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
        .buttonStyle(PlainButtonStyle())
    }
}
