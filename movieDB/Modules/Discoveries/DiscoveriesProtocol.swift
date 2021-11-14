//
//  DiscoveriesProtocol.swift
//  movieDB
//
//  Created by Santo Michael Sihombing on 13/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.

public protocol DiscoveriesDelegate {
    
}

protocol DiscoveriesViewToPresenterProtocol: AnyObject {
    var view: DiscoveriesPresenterToViewProtocol? { get set }
    var interactor: DiscoveriesPresenterToInteractorProtocol? { get set }
    var router: DiscoveriesPresenterToRouterProtocol? { get set }
    
    func fetchDiscoveries(genreId: Int, page: Int)
    func goToMovieDetails(movieId: Int, moreLikeThese: [(String, Int)], movies: [Movie], from: DiscoveriesVC)
}

protocol DiscoveriesPresenterToRouterProtocol: AnyObject {
    func createModule() -> DiscoveriesVC
    func goToMovieDetails(movieId: Int, moreLikeThese: [(String, Int)], movies: [Movie], from: DiscoveriesVC)
}

protocol DiscoveriesPresenterToViewProtocol: AnyObject {
    func didFetchDiscoveries(movies: [Movie], page: Int, totalPages: Int)
}

protocol DiscoveriesInteractorToPresenterProtocol: AnyObject {
    func didFetchDiscoveries(movies: [Movie], page: Int, totalPages: Int)
}

protocol DiscoveriesPresenterToInteractorProtocol: AnyObject {
    var presenter: DiscoveriesInteractorToPresenterProtocol? { get set }
    func fetchDiscoveries(genreId: Int, page: Int) -> Void
}
