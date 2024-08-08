//
//  ContentViewModel.swift
//  nineDotsSTask
//
//  Created by Swapnil on 08/08/24.
//

import Foundation
import SwiftUI
@MainActor
class ContentViewModel: ObservableObject {
    @Published var images: [UIImage] = []
    @Published var searchText: String = ""
    @Published var filteredListData: [String] = ["Apple", "Banana", "Cherry", "Date", "Elderberry", "Fig", "Grape", "Apple", "Banana", "Cherry", "Date", "Elderberry", "Fig", "Grape"]
    
    let imageLoader: ImageLoaderProtocol
    let imageUrls = [
        "https://unsplash.com/photos/a-cell-phone-on-a-stand-next-to-a-keyboard-0NWl3EbkUDg",
        "https://unsplash.com/photos/silver-macbook-beside-white-ceramic-mug-on-brown-wooden-table-n4MLnDMOEf0"
    ]

    init(imageLoader: ImageLoaderProtocol = ImageLoader()) {
          self.imageLoader = imageLoader
          Task {
              await loadImages()
          }
      }


    // Load images asynchronously using async/await
    func loadImages() async {
        var loadedImages: [UIImage] = []
        for url in imageUrls {
            do {
                if let image = try await imageLoader.fetchImage(from: url) {
                    loadedImages.append(image)
                }
            } catch {
                print("Error loading image from \(url): \(error)")
            }
        }
        images = loadedImages
    }

    // Filter the list data based on search text
    func filterList() {
        if searchText.isEmpty {
            filteredListData = ["Apple", "Banana", "Cherry", "Date", "Elderberry", "Fig", "Grape", "Apple", "Banana", "Cherry", "Date", "Elderberry", "Fig", "Grape"]
        } else {
            filteredListData = filteredListData.filter { $0.contains(searchText) }
        }
    }
}
