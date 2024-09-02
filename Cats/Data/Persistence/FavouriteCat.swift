//
//  FavouriteCat.swift
//  Cats
//
//  Created by esther.huecas.local on 2/9/24.
//

import Foundation
import SwiftData

@Model
class FavouriteCat {
    var primaryId: String
    var mimeType: String
    var size: Int
    var tags: [String]
    
    init(primaryId: String, mimeType: String, size: Int, tags: [String]) {
        self.primaryId = primaryId
        self.mimeType = mimeType
        self.size = size
        self.tags = tags
    }
}

extension FavouriteCat {
    convenience init(from cat: CatModel) {
        self.init(primaryId: cat._id,
                  mimeType: cat.mimetype,
                  size: cat.size,
                  tags: cat.tags)
    }
}
