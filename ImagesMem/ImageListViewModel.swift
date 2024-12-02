//
//  ImageListViewModel.swift
//  ImagesMem
//
//  Created by Marcelo Sampaio on 27/11/24.
//

import SwiftUI

@MainActor
class ImageListViewModel: ObservableObject {
    @Published var images: [ImageItem] = []
    @Published var cachedImages: [String: UIImage] = [:]

    init() {
        fetchImageURLs()
    }

    private func fetchImageURLs() {
        images = (1...50).map {
            ImageItem(url: "https://picsum.photos/200/300?random=\($0)")
        }
    }

    func loadImage(url: String) async -> UIImage? {
        if let cachedImage = cachedImages[url] {
            return cachedImage
        }

        guard let imageURL = URL(string: url) else { return nil }

        do {
            let (data, _) = try await URLSession.shared.data(from: imageURL)
            if let image = UIImage(data: data) {
                cachedImages[url] = image
                return image
            }
        } catch {
            print("Error downloading image: \(error)")
        }
        return nil
    }
}
