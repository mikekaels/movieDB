//
//  MovieDetailsPresenter.swift
//  movieDB
//
//  Created by Santo Michael Sihombing on 13/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

class MovieDetailsPresenter: MovieDetailsViewToPresenterProtocol {
    
    
    var view: MovieDetailsPresenterToViewProtocol?
    var router: MovieDetailsPresenterToRouterProtocol?
    var interactor: MovieDetailsPresenterToInteractorProtocol?
    
    func fetchMovieDetails(movieId: Int) {
        interactor?.fetchMovieDetails(movieId: movieId)
    }
    
    func fetchMovieVideo(movieId: Int) {
        interactor?.fetchMovieVideo(movieId: movieId)
    }
    
    func fetchMovieReviews(movieId: Int, page: Int) {
        interactor?.fetchMovieReviews(movieId: movieId, page: page)
    }
    
    func goToNextMovie(movies: [Movie], moreLikeThis: [(String, Int)], movieId: Int, from: MovieDetailsVC) {
        router?.goToNextMovie(movies: movies, moreLikeThis: moreLikeThis, movieId: movieId, from: from)
    }
}

extension MovieDetailsPresenter: MovieDetailsInteractorToPresenterProtocol {
    func didFetchMovieVideo(movieVideo: [MovieVideo]) {
        view?.didFetchMovieVideo(movieVideo: movieVideo)
    }
    
    func didFetchMovieDetails(movieDetails: MovieDetails) {
        view?.didFetchMovieDetails(movieDetails: movieDetails)
    }
    
    func didFetchMovieReviews(movieReviews: [Review], page: Int, totalPages: Int) {
        view?.didFetchMovieReviews(movieReviews: movieReviews, page: page, totalPages: totalPages)
    }
}
