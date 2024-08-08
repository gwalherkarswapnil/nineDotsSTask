//
//  ImageLoader.swift
//  nineDotsSTask
//
//  Created by Swapnil on 08/08/24.
//
import SwiftUI
import Foundation
// Actor for managing downloaded images
protocol ImageLoaderProtocol {
    func fetchImage(from url: String) async throws -> UIImage?
}
actor ImageLoader: ImageLoaderProtocol {
    private var images: [String: UIImage] = [:]

    func fetchImage(from url: String) async throws -> UIImage? {
        if let image = images[url] {
            return image
        }
        
        guard let imageUrl = URL(string: url) else {
            return nil
        }

        let (data, _) = try await URLSession.shared.data(from: imageUrl)
        if let image = UIImage(data: data) {
            images[url] = image
            return image
        }
        return nil
    }
}
