//
//  ContentView.swift
//  nineDotsSTask
//
//  Created by Swapnil on 08/08/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ContentViewModel()
    @State private var searchBarOffset: CGFloat = 0
    @State private var isSearchBarPinned = false

    var body: some View {
        VStack(spacing: 0) {
            // Scrollable Image Carousel
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(viewModel.images, id: \.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.width, height: 200)
                            .clipped()
                    }
                }
            }
            .frame(height: 200)
            .padding(.bottom)

            // ScrollView for content and sticky search bar
            ScrollViewReader { scrollViewProxy in
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 0) {
                        // Sticky Search Bar
                        SearchBar(text: $viewModel.searchText)
                            .background(Color.white)
                            .zIndex(1)
                            .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 2)
                            .padding(.bottom, 8)
                            .id("searchBar")

                        // List of items with search bar
                        ForEach(viewModel.filteredListData, id: \.self) { item in
                            HStack {
                                Image(systemName: "photo")
                                Text(item)
                                    .padding()
                                Spacer()
                            }
                            .padding(.leading)
                            Divider()
                        }
                    }
                    .background(Color.white)
                }
                .onChange(of: viewModel.searchText) { _ in
                    viewModel.filterList()
                }
            }
        }
        .background(Color(.systemGroupedBackground))
    }
}

struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField("Search", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(8)
        .padding(.horizontal)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
