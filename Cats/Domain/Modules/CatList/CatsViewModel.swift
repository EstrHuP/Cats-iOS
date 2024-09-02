//
//  CatsViewModel.swift
//  Cats
//
//  Created by esther.huecas.local on 22/8/24.
//

import Foundation

@MainActor
class CatsViewModel: ObservableObject {
    
    @Published var cats: [CatModel] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var favoriteCats: Set<String> = []
    
    private var limitValue = 100
    private var hasMoreData = true
    
    func loadCats() async {
        guard !isLoading, hasMoreData else { return }
        isLoading = true
        
        do {
            let newCats = try await ApiService.shared.getAllCatsInfinity(limit: limitValue)
            if newCats.isEmpty {
                hasMoreData = false
            } else {
                cats.append(contentsOf: newCats)
                limitValue += 100
            }
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func isFavorite(_ cat: CatModel) -> Bool {
        favoriteCats.contains(cat._id)
    }
    
    func addFavorite(_ cat: CatModel) {
        favoriteCats.insert(cat._id)
        print("Saving...", cat.id)
    }
    
    func removeFavorite(_ cat: CatModel) {
        favoriteCats.remove(cat._id)
        print("Removing...", cat.id)
    }
}
