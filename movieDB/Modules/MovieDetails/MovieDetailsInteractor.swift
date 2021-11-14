//
//  MovieDetailsInteractor.swift
//  movieDB
//
//  Created by Santo Michael Sihombing on 13/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Alamofire

class MovieDetailsInteractor: MovieDetailsPresenterToInteractorProtocol {
var presenter: MovieDetailsInteractorToPresenterProtocol?
    
    private lazy var httpService = MovieHttpService()
    
}

extension MovieDetailsInteractor {
    
    func fetchMovieReviews(movieId: Int, page: Int) {
        do {
            try MovieHttpRouter
                .getMovieReviews(movieId: movieId, page: page)
                .request(usingHttpService: httpService)
                .responseJSON { (result) in
                    guard [200, 201].contains(result.response?.statusCode), let data = result.data else { return }

                    do {
                        let result = try JSONDecoder().decode(ReviewsResponse.self, from: data)

                        self.presenter?.didFetchMovieReviews(movieReviews: result.reviews, page: result.page, totalPages: result.totalPages)
                    } catch {
                        print("Something went wrong when parsing genres response with error = \(error)")
                    }
                }
        } catch {
            print("Something went wrong while fetching genre with error = \(error)")
        }
    }
    
    func fetchMovieDetails(movieId: Int) {
        do {
            try MovieHttpRouter
                .getMovieDetails(movieId: movieId)
                .request(usingHttpService: httpService)
                .responseJSON { (result) in
                    guard [200, 201].contains(result.response?.statusCode), let data = result.data else { return }

                    do {
                        let result = try JSONDecoder().decode(MovieDetails.self, from: data)

                        self.presenter?.didFetchMovieDetails(movieDetails: result)
                    } catch {
                        print("Something went wrong when parsing genres response with error = \(error)")
                    }
                }
        } catch {
            print("Something went wrong while fetching genre with error = \(error)")
        }
    }
    
    func fetchMovieVideo(movieId: Int) {
        do {
            try MovieHttpRouter
                .getTrailerVideo(movieId: movieId)
                .request(usingHttpService: httpService)
                .responseJSON { (result) in
                    guard [200, 201].contains(result.response?.statusCode), let data = result.data else { return }

                    do {
                        let result = try JSONDecoder().decode(movieVideoResponse.self, from: data)
                        self.presenter?.didFetchMovieVideo(movieVideo: result.results)
                    } catch {
                        print("Something went wrong when parsing genres response with error = \(error)")
                    }
                }
        } catch {
            print("Something went wrong while fetching genre with error = \(error)")
        }
    }
}
