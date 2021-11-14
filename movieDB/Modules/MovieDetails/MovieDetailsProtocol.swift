//
//  MovieDetailsProtocol.swift
//  movieDB
//
//  Created by Santo Michael Sihombing on 13/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.

public protocol MovieDetailsDelegate {
    
}

protocol MovieDetailsViewToPresenterProtocol: AnyObject {
    var view: MovieDetailsPresenterToViewProtocol? { get set }
    var interactor: MovieDetailsPresenterToInteractorProtocol? { get set }
    var router: MovieDetailsPresenterToRouterProtocol? { get set }
    
    func fetchMovieDetails(movieId: Int)
    func fetchMovieVideo(movieId: Int)
    func fetchMovieReviews(movieId: Int, page: Int)
    func goToNextMovie(movies: [Movie], moreLikeThis: [(String, Int)], movieId: Int, from: MovieDetailsVC)
}

protocol MovieDetailsPresenterToInteractorProtocol: AnyObject {
    var presenter: MovieDetailsInteractorToPresenterProtocol? { get set }
    func fetchMovieDetails(movieId: Int)
    func fetchMovieVideo(movieId: Int)
    func fetchMovieReviews(movieId: Int, page: Int)
}

protocol MovieDetailsPresenterToViewProtocol: AnyObject {
    func didFetchMovieDetails(movieDetails: MovieDetails)
    func didFetchMovieVideo(movieVideo: [MovieVideo])
    func didFetchMovieReviews(movieReviews: [Review], page: Int, totalPages: Int)
}

protocol MovieDetailsInteractorToPresenterProtocol: AnyObject {
    func didFetchMovieDetails(movieDetails: MovieDetails)
    func didFetchMovieVideo(movieVideo: [MovieVideo])
    func didFetchMovieReviews(movieReviews: [Review], page: Int, totalPages: Int)
}

protocol MovieDetailsPresenterToRouterProtocol: AnyObject {
    func createModule() -> MovieDetailsVC
    func goToNextMovie(movies: [Movie], moreLikeThis: [(String, Int)], movieId: Int, from: MovieDetailsVC)
}
