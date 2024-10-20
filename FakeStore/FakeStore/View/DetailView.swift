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
    private let idOfProductText = "ID productu:"
    private let priceOfProductText = "Cena:"
    private let imageSize: CGFloat = 200
    
    var body: some View {
        VStack(spacing: .thirty) {
            if viewModel.isLoaded == false {
                ProgressView("Loading..")
                    .padding()
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
            } else if let product = viewModel.productById {
                AsyncImageLoader(product: product, widthOfImage: imageSize, heightOfImage: imageSize)
                    .padding(.top, .sixty)
                titleAndDescription(product)
                    .padding(.top, .fortyFive)
                idAndPrice(product)
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

//MARK: View components

extension DetailView {
    func titleAndDescription(_ product: Product) -> some View {
        return VStack(spacing: .twenty) {
            Text(product.title)
                .fontWeight(.heavy)
                .foregroundStyle(.blueText)
            Text(product.description)
                .foregroundStyle(.gray)
                .font(.footnote)
            
        }
        .padding(.horizontal, .thirty)
    }
    func idAndPrice(_ product: Product) -> some View {
        HStack {
            idOfProduct(product)
            Spacer()
            priceOfProduct(product)
        }
        .padding(.horizontal, .thirty)
    }
    
    func idOfProduct(_ product: Product) -> some View {
        VStack(alignment: .leading) {
            Text(idOfProductText)
                .foregroundStyle(.gray)
                .font(.footnote)
            Text("\(product.id)")
        }
    }
    
    func priceOfProduct(_ product: Product) -> some View {
        VStack(alignment: .trailing) {
            Text(priceOfProductText)
                .foregroundStyle(.gray)
                .font(.footnote)
            Text("\((product.price))" + "€")
        }
    }
}
