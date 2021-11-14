//
//  GenresEntity.swift
//  movieDB
//
//  Created by Santo Michael Sihombing on 13/11/21.
//

import Foundation

struct Genres: Decodable {
    let genres: [Genre]
    
    private enum CodingKeys: String, CodingKey {
        case genres = "genres"
    }
}

struct Genre: Decodable {
    let id: Int
    let name: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
}
