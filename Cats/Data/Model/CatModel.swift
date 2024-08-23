//
//  CatModel.swift
//  Cats
//
//  Created by esther.huecas.local on 22/8/24.
//

import Foundation

struct CatModel: Codable, Identifiable {
    var id: String { _id }
    
    let _id: String
    let mimetype: String
    let size: Int
    let tags: [String]
    
    var imageURL: URL? {
        return URL(string: "https://cataas.com/cat/\(id)")
    }
}
