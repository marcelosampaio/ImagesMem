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
    private let imageCache = NSCache<NSString, UIImage>()
    private var inProgressTasks: [String: Task<UIImage?, Never>] = [:]

    init() {
        fetchImageURLs()
    }

    private func fetchImageURLs() {
        images = (1...50).map {
            ImageItem(url: "https://picsum.photos/200/300?random=\($0)")
        }
    }

    func loadImage(url: String) async -> UIImage? {
        if let cachedImage = imageCache.object(forKey: url as NSString) {
            return cachedImage
        }

        if let existingTask = inProgressTasks[url] {
            return await existingTask.value
        }

        let task = Task<UIImage?, Never> {
            defer { inProgressTasks.removeValue(forKey: url) }

            guard let imageURL = URL(string: url) else { return nil }
            do {
                let (data, _) = try await URLSession.shared.data(from: imageURL)
                if let image = UIImage(data: data) {
                    imageCache.setObject(image, forKey: url as NSString)
                    return image
                }
            } catch {
                print("Error downloading image: \(error)")
            }
            return nil
        }

        inProgressTasks[url] = task
        return await task.value
    }
}
