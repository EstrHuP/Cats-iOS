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
    @Published var errorMessage: String?
    
    func loadCats() async {
        do {
            cats = try await ApiService.shared.fetchAllCats()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
