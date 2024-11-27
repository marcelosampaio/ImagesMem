//
//  ContentView.swift
//  ImagesMem
//
//  Created by Marcelo Sampaio on 27/11/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ImageListViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.images) { imageItem in
                NavigationLink(
                    destination: FullScreenImageView(
                        imageURL: imageItem.url, viewModel: viewModel)
                ) {
                    ImageRow(imageURL: imageItem.url, viewModel: viewModel)
                }
            }
            .navigationTitle("Image List")
        }
    }
}

#Preview {
    ContentView()
}
