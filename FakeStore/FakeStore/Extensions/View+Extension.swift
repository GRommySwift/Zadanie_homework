//
//  View+Extension.swift
//  FakeStore
//
//  Created by Roman on 19/10/2024.
//

import SwiftUI
// Custom padding number by ENUM
extension View {
    func padding(_ edges: Edge.Set = .all, _ theme: Padding) -> some View {
        self.padding(edges, theme.rawValue)
    }
}
// Action sheet for filter on MainView
extension View {
    func confirmationDialog(showPicker: Binding<Bool>, viewModel: FakeStoreViewModel, clearFilterText: String) -> some View {
        self
            .confirmationDialog("Select filter", isPresented: showPicker) {
                ForEach(viewModel.categories, id: \.self) { categories in
                    Button((categories == viewModel.selectedCategory ? clearFilterText + " " + categories : categories),
                           role: categories == viewModel.selectedCategory ? .destructive : .none) {
                        if viewModel.selectedCategory == categories {
                            viewModel.resetFilter()
                            showPicker.wrappedValue = false
                        } else {
                            viewModel.applyFilter(categories)
                            showPicker.wrappedValue = false
                        }
                    }
                }
            }
    }
}
// Navigation for the FakeStoreView, works on background and hidden.
// It's the best solution(my opinion) to hide disclosure arrows of NavigationLink.
extension View {
    func backgroundNavigation(_ viewModel: FakeStoreViewModel) -> some View {
        let binding = Binding<Int?>(
            get: { viewModel.selectedProductId },
            set: { viewModel.selectedProductId = $0 }
        )
        
        return self
            .background(
                NavigationLink(
                    destination: DetailView(productID: viewModel.selectedProductId ?? 0, viewModel: viewModel),
                    tag: viewModel.selectedProductId ?? 0,
                    selection: binding
                ) {
                    EmptyView()
                }
                    .hidden()
            )}
}
