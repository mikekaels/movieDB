//
//  HttpService.swift
//  movieDB
//
//  Created by Santo Michael Sihombing on 13/11/21.
//

import Alamofire

protocol HttpService {
    var sessionManager: Session { get set }
    
    func request(_ urlRequest: URLRequestConvertible) -> DataRequest
}
