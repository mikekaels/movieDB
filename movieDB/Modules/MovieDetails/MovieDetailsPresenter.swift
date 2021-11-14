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
}

extension MovieDetailsPresenter: MovieDetailsInteractorToPresenterProtocol {
    func didFetchMovieVideo(movieVideo: [MovieVideo]) {
        view?.didFetchMovieVideo(movieVideo: movieVideo)
    }
    
    func didFetchMovieDetails(movieDetails: MovieDetails) {
        view?.didFetchMovieDetails(movieDetails: movieDetails)
    }
}
