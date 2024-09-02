//
//  ContentView.swift
//  Cats
//
//  Created by esther.huecas.local on 22/8/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = CatsViewModel()
    
    var body: some View {
        List(viewModel.cats) { cat in
            HStack {
                if let url = cat.imageURL {
                    ZStack(alignment: .bottomTrailing) {
                        AsyncImage(url: url) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let catImage):
                                catImage
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 150)
                            case .failure:
                                Image(systemName: "photo")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            @unknown default:
                                EmptyView()
                            }
                        }
                        Button(action: {
                            viewModel.isFavorite(cat) ? viewModel.removeFavorite(cat) : viewModel.addFavorite(cat)
                        }, label: {
                            Image(systemName: viewModel.isFavorite(cat) ? "heart.fill" : "heart")
                                .resizable()
                                .frame(width: 40, height: 30)
                                .foregroundColor(.red.opacity(0.7))
                                .padding()
                        })
                    }
                }
                VStack(alignment: .leading) {
                    Text("Tags: \(cat.tags.joined(separator: ", "))")
                }
            }
            
            .onAppear {
                if cat == viewModel.cats.last {
                    Task {
                        await viewModel.loadCats()
                    }
                }
            }
            
            if viewModel.isLoading {
                ProgressView("Loading more cats...")
            }
        }
        .navigationTitle("Cats")
        .task {
            await viewModel.loadCats()
        }
    }
}

#Preview {
    ContentView()
}
