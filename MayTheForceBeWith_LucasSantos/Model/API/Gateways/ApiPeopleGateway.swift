//
//  ApiPeopleGateway.swift
//  MayTheForceBeWith_LucasSantos
//
//  Created by Lucas  Felipe on 14/01/2020.
//  Copyright © 2020 Lucas  Felipe. All rights reserved.
//

import Foundation

class ApiPeopleGateway: PeopleGateway {
    var apiClient: ApiClient
    
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }
    
    func fetchPeople(in page: Int, completion: @escaping (Result<ApiPeopleResponse>) -> Void) {
        let peopleRequest = PeopleRequest(with: page)
        peform(request: peopleRequest, completion: completion)
    }
    
    func fetchPeople(by name: String, completion: @escaping FetchPeopleCompletionHandler) {
        let peopleRequest = PeopleRequest(with: name)
        peform(request: peopleRequest, completion: completion)
    }
    
    private func peform(request: PeopleRequest, completion: @escaping (Result<ApiPeopleResponse>) -> Void) {
        self.apiClient.execute(request: request) { (result: Result<ApiResponse<ApiPeopleResponse>>) in
            switch result {
                case let .fail(error):
                    completion(.fail(error))
                case let .success(response):
                    let people = response.entity
                    completion(.success(people))
            }
        }
    }
}
