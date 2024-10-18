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
            .navigationTitle("Produkty")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Filter") {
                    showPicker.toggle()
                }
            }
            .overlay(
                showPicker ? categoryPickerOverlay : nil
            )
        }
    }
}

#Preview {
    MainView()
}

extension MainView {
    var categoryPickerOverlay: some View {
            VStack {
                Text("Select Category").font(.headline).padding()
                List {
                    ForEach(viewModel.categories, id: \.self) { category in
                        HStack {
                            Text(category)
                            Spacer()
                            if viewModel.selectedCategory == category {
                                Text("Remove category \(viewModel.selectedCategory ?? "")")
                                    .foregroundColor(.red)
                            }
                        }
                        .contentShape(Rectangle()) // Делает весь HStack кликабельным
                        .onTapGesture {
                            if viewModel.selectedCategory == category {
                                viewModel.selectedCategory = nil // Удалить категорию, если она уже выбрана
                                viewModel.fetchProducts() // Загрузить все продукты без фильтра
                            } else {
                                viewModel.selectedCategory = category // Выбрать категорию
                                viewModel.fetchProducts() // Загрузить продукты для категории
                            }
                            showPicker.toggle() // Скрыть оверлей после выбора
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 300) // Ограничение высоты таблицы
                .background(Color(.systemBackground))
                .cornerRadius(10)
                .shadow(radius: 10)
                .padding()
            }
            .background(Color.black.opacity(0.4).ignoresSafeArea()) // Полупрозрачный фон для оверлея
            .transition(.move(edge: .bottom)) // Анимация появления оверлея
            .animation(.easeInOut, value: showPicker)
        }
}
