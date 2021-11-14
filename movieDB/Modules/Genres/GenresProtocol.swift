//
//  GenresProtocol.swift
//  movieDB
//
//  Created by Santo Michael Sihombing on 13/11/21.
//

protocol GenresViewToPresenterProtocol: AnyObject {
    var view: GenresPresenterToViewProtocol? { get set }
    var interactor: GenresPresenterToInteractorProtocol? { get set }
    var router: GenresPresenterToRouterProtocol? { get set }
    
    func fetchGenres() -> Void
    func goToDiscoveries(genreId: Int, from: GenresVC)
}

protocol GenresPresenterToRouterProtocol: AnyObject {
    func createModule() -> GenresVC
    func goToDiscoveries(genreId: Int, from: GenresVC)
}

protocol GenresPresenterToViewProtocol: AnyObject {
    func didFetchGenres(genres: [Genre])
}

protocol GenresInteractorToPresenterProtocol: AnyObject {
    func didFetchGenres(genres: [Genre])
}

protocol GenresPresenterToInteractorProtocol: AnyObject {
    var presenter: GenresInteractorToPresenterProtocol? { get set }
    func fetchGenres() -> Void
}
