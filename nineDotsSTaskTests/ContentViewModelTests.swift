//
//  ContentViewModelTests.swift
//  nineDotsSTaskTests
//
//  Created by Swapnil on 08/08/24.
//

import Foundation
import XCTest
@testable import nineDotsSTask

@MainActor
final class ContentViewModelTests: XCTestCase {
    var viewModel: ContentViewModel!
    var mockImageLoader: MockImageLoader!

    override func setUp() {
        super.setUp()
        mockImageLoader = MockImageLoader()
        viewModel = ContentViewModel(imageLoader: mockImageLoader)
    }

    func testLoadImagesSuccess() async {
        // Arrange
        let expectedImage = UIImage(systemName: "star") // Use a valid UIImage for your tests
        mockImageLoader.mockImage = expectedImage

        // Act
        await viewModel.loadImages()

        // Assert
        XCTAssertEqual(viewModel.images.count, 2)
        XCTAssertEqual(viewModel.images.first, expectedImage)
    }

    func testFilterListEmptySearchText() {
        // Act
        viewModel.searchText = ""
        viewModel.filterList()

        // Assert
        XCTAssertEqual(viewModel.filteredListData, ["Apple", "Banana", "Cherry", "Date", "Elderberry", "Fig", "Grape", "Apple", "Banana", "Cherry", "Date", "Elderberry", "Fig", "Grape"])
    }

    func testFilterListWithSearchText() {
        // Act
        viewModel.searchText = "Apple"
        viewModel.filterList()

        // Assert
        XCTAssertEqual(viewModel.filteredListData, ["Apple", "Apple"])
    }
}

// MARK: - Mock Classes

class MockImageLoader: ImageLoaderProtocol {
    var mockImage: UIImage?

    func fetchImage(from url: String) async throws -> UIImage? {
        return mockImage
    }
}
