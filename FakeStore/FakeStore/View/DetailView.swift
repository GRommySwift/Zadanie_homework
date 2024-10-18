//
//  DetailView.swift
//  FakeStore
//
//  Created by Roman on 16/10/2024.
//

import SwiftUI

struct DetailView: View {
    
    let productID: Int
    @ObservedObject var viewModel: FakeStoreViewModel
    
    var body: some View {
        VStack(spacing: 40) {
            if viewModel.isLoaded == false {
                ProgressView("Loading..")
                    .padding()
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
            } else if let product = viewModel.productById {
                AsyncImageLoader(product: product, widthOfImage: 200, heightOfImage: 200)
                    .padding(.vertical, 40)
                titleAndDescription(product: product)
                idAndPrice(product: product)
                Spacer()
                    .navigationTitle(product.category)
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
        .onAppear() {
            viewModel.fetchProductByID(id: productID)
        }
    }
}

#Preview {
    DetailView(productID: 2, viewModel: FakeStoreViewModel())
}

//MARK: Extension of DetailView

extension DetailView {
    func titleAndDescription(product: Product) -> some View {
        return VStack(spacing: 40) {
            Text(product.title)
                .fontWeight(.bold)
                .foregroundStyle(.blueText)
            Text(product.description)
                .foregroundStyle(.gray)
                .font(.footnote)
            
        }
        .padding(.horizontal, 30)
    }
    func idAndPrice(product: Product) -> some View {
        HStack {
            idOfProduct(product: product)
            Spacer()
            priceOfProduct(product: product)
        }
        .padding(.horizontal, 30)
    }
    
    func idOfProduct(product: Product) -> some View {
        VStack(alignment: .leading) {
            Text("ID productu:")
                .foregroundStyle(.gray)
                .font(.footnote)
            Text("\(product.id)")
        }
    }
    
    func priceOfProduct(product: Product) -> some View {
        VStack(alignment: .trailing) {
            Text("Cena:")
                .foregroundStyle(.gray)
                .font(.footnote)
            Text("\((product.price))" + "€")
        }
    }
}
