//
//  PeopleRequest.swift
//  MayTheForceBeWith_LucasSantos
//
//  Created by Lucas  Felipe on 13/01/2020.
//  Copyright © 2020 Lucas  Felipe. All rights reserved.
//

import Foundation

struct PeopleRequest: ApiRequest {
    private var params: [String: String] = [
        "page": "1"
    ]
    
    init(with page: Int) {
        params["page"] = "\(page)"
    }
    
    init(with name: String) {
        params["name"] = name
    }
    
    var urlRequest: URLRequest {
        var urlComponents = URLComponents(string: Constants.URL_PEOPLE)!
        urlComponents.queryItems = params.map { (key, value) -> URLQueryItem in
            return URLQueryItem(name: key, value: value)
        }
        var urlRequest = URLRequest(url: urlComponents.url!)
        urlRequest.httpMethod = "GET"
        return urlRequest
    }
}
