//
//  DiscoveriesRouter.swift
//  movieDB
//
//  Created by Santo Michael Sihombing on 13/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.


import UIKit

public class DiscoveriesRouter: DiscoveriesPresenterToRouterProtocol{
    
    
    
    
    public static let shared = DiscoveriesRouter()
    
    func initialize() -> DiscoveriesVC {
        return createModule()
    }
    
    func createModule() -> DiscoveriesVC {
        let view = DiscoveriesVC()
        
        let presenter: DiscoveriesViewToPresenterProtocol & DiscoveriesInteractorToPresenterProtocol = DiscoveriesPresenter()
        
        let interactor: DiscoveriesPresenterToInteractorProtocol = DiscoveriesInteractor()
        
        let router: DiscoveriesPresenterToRouterProtocol = DiscoveriesRouter()
        
        view.presentor = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        
        return view
    }
    
    func goToMovieDetails(movieId: Int, moreLikeThese: [(String, Int)], movies: [Movie], from: DiscoveriesVC) {
        let vc = MovieDetailsRouter().createModule()
        vc.movieId = movieId
        vc.moreLikeTheseUrl = moreLikeThese
        vc.movieList = movies
        from.navigationController?.pushViewController(vc, animated: true)
    }
}
