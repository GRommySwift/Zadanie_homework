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
            .navigationTitle(viewModel.selectedCategory ?? "Products")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Filter") {
                    showPicker.toggle()
                }
            }
            .confirmationDialog("", isPresented: $showPicker) {
                ForEach(viewModel.categories, id: \.self) { categories in
                    Button((categories == viewModel.selectedCategory ? "Zrušiť filter \(categories)" : categories),
                           role: categories == viewModel.selectedCategory ? .destructive : .none) {
                        if viewModel.selectedCategory == categories {
                            viewModel.resetFilter()
                        } else {
                            viewModel.applyFilter(categories)
                        }
                    }
                }
            }
            
        }
    }
}

#Preview {
    MainView()
}
