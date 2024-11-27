//
//  ImageCache.swift
//  ImagesMem
//
//  Created by Marcelo Sampaio on 27/11/24.
//

import UIKit

class ImageCache {
    static let shared = ImageCache()

    private init() {}

    private var cache = NSCache<NSString, UIImage>()

    func getImage(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }

    func saveImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
}
