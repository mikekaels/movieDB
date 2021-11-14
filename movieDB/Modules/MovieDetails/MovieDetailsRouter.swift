//
//  MovieDetailsRouter.swift
//  movieDB
//
//  Created by Santo Michael Sihombing on 13/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.


import UIKit

public class MovieDetailsRouter: MovieDetailsPresenterToRouterProtocol{
    
    
    public static let shared = MovieDetailsRouter()
    
    func initialize() -> MovieDetailsVC {
        return createModule()
    }
    
    func createModule() -> MovieDetailsVC {
        let view = MovieDetailsVC()
        
        let presenter: MovieDetailsViewToPresenterProtocol & MovieDetailsInteractorToPresenterProtocol = MovieDetailsPresenter()
        
        let interactor: MovieDetailsPresenterToInteractorProtocol = MovieDetailsInteractor()
        
        let router: MovieDetailsPresenterToRouterProtocol = MovieDetailsRouter()
        
        view.presentor = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        
        return view
    }
    
    func goToNextMovie(movies: [Movie], moreLikeThis: [(String, Int)], movieId: Int, from: MovieDetailsVC) {
        let vc = createModule()
        vc.movieId = movieId
        vc.movieList = movies
        vc.moreLikeTheseUrl = moreLikeThis
        
        from.navigationController?.pushViewController(vc, animated: true)
    }
}
