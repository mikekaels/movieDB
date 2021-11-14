//
//  GenresRouter.swift
//  movieDB
//
//  Created by Santo Michael Sihombing on 13/11/21.
//

import UIKit

public class GenresRouter: GenresPresenterToRouterProtocol{
    public static let shared = GenresRouter()
    
    func initialize() -> GenresVC {
        return createModule()
    }
    
    func createModule() -> GenresVC {
        let view = GenresVC()
        
        let presenter: GenresViewToPresenterProtocol & GenresInteractorToPresenterProtocol = GenresPresenter()
        
        let interactor: GenresPresenterToInteractorProtocol = GenresInteractor()
        
        let router: GenresPresenterToRouterProtocol = GenresRouter()
        
        view.presentor = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        
        return view
    }
    
    func goToDiscoveries(genreId: Int, from: GenresVC) {
        let vc = DiscoveriesRouter().createModule()
        vc.genreId = genreId
        from.navigationController?.pushViewController(vc, animated: true)
    }
}
