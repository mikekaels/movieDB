//
//  GenreService.swift
//  movieDB
//
//  Created by Santo Michael Sihombing on 13/11/21.
//

import Alamofire

class GenreService {
    private lazy var httpService = MovieHttpService()
}

extension GenreService {
    func fetchGenres(completion: @escaping ([Genre]) -> (Void)) {
        
    }
}

extension GenreService {
    private static func parseGenres(result: DataResponse<Any, AFError>) -> [Genre] {
        

        return []
    }
}
