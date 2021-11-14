//
//  DiscoveriesPresenter.swift
//  movieDB
//
//  Created by Santo Michael Sihombing on 13/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

class DiscoveriesPresenter: DiscoveriesViewToPresenterProtocol {
    
    
    var view: DiscoveriesPresenterToViewProtocol?
    var router: DiscoveriesPresenterToRouterProtocol?
    var interactor: DiscoveriesPresenterToInteractorProtocol?

    func goToMovieDetails(movieId: Int, from: DiscoveriesVC) {
        
    }
    
    func goToMovieDetails(movieId: Int, moreLikeThese: [(String, Int)], movies: [Movie], from: DiscoveriesVC) {
        router?.goToMovieDetails(movieId: movieId, moreLikeThese: moreLikeThese, movies: movies, from: from)
    }
}

extension DiscoveriesPresenter: DiscoveriesInteractorToPresenterProtocol {
    func didFetchDiscoveries(movies: [Movie], page: Int, totalPages: Int) {
        view?.didFetchDiscoveries(movies: movies, page: page, totalPages: totalPages)
    }
    
    func fetchDiscoveries(genreId: Int, page: Int) {
        interactor?.fetchDiscoveries(genreId: genreId, page: page)
    }
}
