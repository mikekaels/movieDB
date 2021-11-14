//
//  MovieHttpService.swift
//  movieDB
//
//  Created by Santo Michael Sihombing on 13/11/21.
//

import Alamofire

final class MovieHttpService: HttpService {
    var sessionManager: Session = Session.default
    
    func request(_ urlRequest: URLRequestConvertible) -> DataRequest {
        return sessionManager.request(urlRequest).validate(statusCode: 200..<600)
    }
    
}
