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
}

protocol MovieDetailsPresenterToRouterProtocol: AnyObject {
    func createModule() -> MovieDetailsVC
}

protocol MovieDetailsPresenterToViewProtocol: AnyObject {
    func didFetchMovieDetails(movieDetails: MovieDetails)
    func didFetchMovieVideo(movieVideo: [MovieVideo])
}

protocol MovieDetailsInteractorToPresenterProtocol: AnyObject {
    func didFetchMovieDetails(movieDetails: MovieDetails)
    func didFetchMovieVideo(movieVideo: [MovieVideo])
}

protocol MovieDetailsPresenterToInteractorProtocol: AnyObject {
    var presenter: MovieDetailsInteractorToPresenterProtocol? { get set }
    func fetchMovieDetails(movieId: Int)
    func fetchMovieVideo(movieId: Int)
}
