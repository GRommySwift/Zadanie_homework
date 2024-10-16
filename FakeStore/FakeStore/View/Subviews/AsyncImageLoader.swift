//
//  AsyncImageLoader.swift
//  FakeStore
//
//  Created by Roman on 16/10/2024.
//

import SwiftUI

struct AsyncImageLoader: View {
    
    let product: Product
    let widthOfImage: CGFloat
    let heightOfImage: CGFloat
    
    var body: some View {
        if let urlOfImage = product.image, let imageURL = URL(string: urlOfImage) {
            AsyncImage(url: imageURL) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .padding()
                        .frame(width: widthOfImage, height: heightOfImage)
                }
            }
        }
    }
}
