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
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let catImage):
                            catImage
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        case .failure:
                            Image(systemName: "photo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        @unknown default:
                            EmptyView()
                        }
                    }
                }
                VStack(alignment: .leading) {
                    Text("Tags: \(cat.tags.joined(separator: ", "))")
                }
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
