//
//  MovieHttpRouter.swift
//  movieDB
//
//  Created by Santo Michael Sihombing on 13/11/21.
//

import Foundation
import Alamofire

enum MovieHttpRouter {
    case getGenres
    case getDiscover(genre: Int, page: Int)
    case getMovieDetails(movieId: Int)
    case getMovieReviews(movieId: Int, page: Int)
    case getTrailerVideo(movieId: Int)
}

extension MovieHttpRouter: HttpRouter {
    
    var baseUrlString: String {
        return "https://api.themoviedb.org/3"
    }
    
    var apiKey: String {
        return "dabd891097ebc46c5b0cab7182d05e30"
    }
    
    var path: String {
        switch self {
            
        case .getGenres:
            return "/genre/movie/list"
        case .getDiscover:
            return "/discover/movie"
        case.getMovieDetails(let movieId):
            return "/movie/\(movieId)"
        case .getMovieReviews(let movieId, _):
            return "/movie/\(movieId)/reviews"
        case .getTrailerVideo(let movieId):
            return "/movie/\(movieId)/videos"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getGenres:
            return .get
        case .getDiscover:
            return .get
        case .getMovieDetails:
            return .get
        case .getMovieReviews:
            return .get
        case .getTrailerVideo:
            return .get
        }
    }
    
    var headers: HTTPHeaders {
        return [
            "Content-Type": "application/json; charset=UTF-8"
        ]
    }
    
    var parameters: Parameters? {
        switch self {
        case .getGenres:
            return [
                "api_key": apiKey
            ]
        case .getDiscover(genre: let genre, page: let page):
            return [
                "api_key": apiKey,
                "with_genres": genre,
                "page": page
            ]
        case .getMovieDetails:
            return [
                "api_key": apiKey
            ]
        case .getMovieReviews(movieId: _, page: let page):
            return [
                "api_key": apiKey,
                "page": page
            ]
        case .getTrailerVideo:
            return [
                "api_key": apiKey
            ]
        }
    }
    
    func body() throws -> Data? {
        switch self {
        case .getDiscover, .getGenres, .getTrailerVideo, .getMovieReviews, .getMovieDetails:
            return nil
        }
    }
}
