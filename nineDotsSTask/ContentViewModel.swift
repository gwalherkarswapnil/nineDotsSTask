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
        "https://images.pexels.com/photos/236937/pexels-photo-236937.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
        "https://images.pexels.com/photos/1374286/pexels-photo-1374286.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
        "https://images.unsplash.com/photo-1462331948351-d0422e4a3d85"
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
