//
//  ApiService.swift
//  Cats
//
//  Created by esther.huecas.local on 22/8/24.
//

import Foundation

class ApiService {
    
    static let shared = ApiService()
    
    func getAllCatsInfinity(limit: Int) async throws -> [CatModel] {
        guard let url = URL(string: "https://cataas.com/api/cats?limit=\(limit)&skip=0") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let cats = try JSONDecoder().decode([CatModel].self, from: data)
        return cats
    }
}
