//
//  DiscoveriesInteractor.swift
//  movieDB
//
//  Created by Santo Michael Sihombing on 13/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Alamofire

class DiscoveriesInteractor: DiscoveriesPresenterToInteractorProtocol {
    var presenter: DiscoveriesInteractorToPresenterProtocol?
    
    private lazy var httpService = MovieHttpService()
}

extension DiscoveriesInteractor {
    func fetchDiscoveries(genreId: Int, page: Int) {
        do {
            try MovieHttpRouter
                .getDiscover(genre: genreId, page: page)
                .request(usingHttpService: httpService)
                .responseJSON { (result) in
                    let (movies, page, totalPages) = self.parseDiscoveries(result: result)
                    
                    self.presenter?.didFetchDiscoveries(movies: movies, page: page, totalPages: totalPages)
                }
        } catch {
            print("Something went wrong while fetching genre with error = \(error)")
        }
    }
}


extension DiscoveriesInteractor {
    private func parseDiscoveries(result: DataResponse<Any, AFError>) -> ([Movie], Int, Int) {
        guard [200, 201].contains(result.response?.statusCode), let data = result.data else { return ([], 0, 0) }
        do {
            let result = try JSONDecoder().decode(DiscoveriesResponse.self, from: data)
            return (result.movies, result.page, result.totalPages)
        } catch {
            print("Something went wrong when parsing genres response with error = \(error)")
        }

        return ([], 0, 0)
    }
}
