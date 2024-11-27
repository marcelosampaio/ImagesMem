//
//  FullScreenImageView.swift
//  ImagesMem
//
//  Created by Marcelo Sampaio on 27/11/24.
//

import SwiftUI

struct FullScreenImageView: View {
    let imageURL: String
    @ObservedObject var viewModel: ImageListViewModel
    @State private var image: UIImage?

    var body: some View {
        ZStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea() 
            } else {
                ProgressView()
            }
        }
        .background(Color.black)
        .onAppear {
            Task {
                image = await viewModel.loadImage(url: imageURL)
            }
        }
    }
}
