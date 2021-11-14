//
//  DiscoveriesModels.swift
//  movieDB
//
//  Created by Santo Michael Sihombing on 13/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

struct DiscoveriesResponse: Decodable {
    var page: Int
    var movies: [Movie]
    var totalPages: Int
    
    enum CodingKeys: String, CodingKey {
        case page = "page"
        case movies = "results"
        case totalPages = "total_pages"
    }
}

struct Movie: Decodable {
    
    var movieTitle, movieOverview, movieImageUrl: String
    var movieId: Int
    
    enum CodingKeys: String, CodingKey {
        case movieTitle    = "title"
        case movieOverview = "overview"
        case movieImageUrl = "poster_path"
        case movieId = "id"
    }
}
