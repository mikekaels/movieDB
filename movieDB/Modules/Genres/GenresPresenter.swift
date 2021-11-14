//
//  GenresPresenter.swift
//  movieDB
//
//  Created by Santo Michael Sihombing on 13/11/21.
//

class GenresPresenter: GenresViewToPresenterProtocol {
    
    var view: GenresPresenterToViewProtocol?
    var router: GenresPresenterToRouterProtocol?
    var interactor: GenresPresenterToInteractorProtocol?
    
    func goToDiscoveries(genreId: Int, from: GenresVC) {
        router?.goToDiscoveries(genreId: genreId, from: from)
    }
}

extension GenresPresenter: GenresInteractorToPresenterProtocol {
    func didFetchGenres(genres: [Genre]) {
        view?.didFetchGenres(genres: genres)
    }
    
    func fetchGenres() {
        interactor?.fetchGenres()
    }
}
