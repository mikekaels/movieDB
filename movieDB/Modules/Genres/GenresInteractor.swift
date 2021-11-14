//
//  GenresInteractor.swift
//  movieDB
//
//  Created by Santo Michael Sihombing on 13/11/21.
//

import Alamofire

class GenresInteractor: GenresPresenterToInteractorProtocol {

    
    var httpService = MovieHttpService()
    
    var presenter: GenresInteractorToPresenterProtocol?
    
    func fetchGenres()-> Void {
        
        do {
            try MovieHttpRouter
                .getGenres
                .request(usingHttpService: httpService)
                .responseJSON { (result) in
                    guard [200, 201].contains(result.response?.statusCode), let data = result.data else { return }
                    do {
                        let result = try JSONDecoder().decode(Genres.self, from: data)
                        self.presenter?.didFetchGenres(genres: result.genres)
                    } catch {
                        print("Something went wrong when parsing genres response with error = \(error)")
                    }
                }
        } catch {
            print("Something went wrong while fetching genre with error = \(error)")
        }
    }
}
