//
//  ImageRow.swift
//  ImagesMem
//
//  Created by Marcelo Sampaio on 27/11/24.
//

import SwiftUI

struct ImageRow: View {
    let imageURL: String
    @ObservedObject var viewModel: ImageListViewModel
    @State private var image: UIImage?

    var body: some View {
        HStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
            } else {
                ProgressView()
                    .frame(width: 100, height: 100)
                    .task {
                        image = await viewModel.loadImage(url: imageURL)
                    }
            }
            Text(imageURL)
                .font(.footnote)
                .lineLimit(1)
                .truncationMode(.tail)
        }
    }
}
