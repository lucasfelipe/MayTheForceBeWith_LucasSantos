//
//  ApiPeopleGatewaySpy.swift
//  MayTheForceBeWith_LucasSantosTests
//
//  Created by Lucas  Felipe on 16/01/2020.
//  Copyright © 2020 Lucas  Felipe. All rights reserved.
//

import Foundation
@testable import MayTheForceBeWith_LucasSantos

class ApiPeopleGatewaySpy: PeopleGateway {
    var fetchPeopleResult: Result<ApiPeopleResponse>!
    
    func fetchPeople(in page: Int, completion: @escaping FetchPeopleCompletionHandler) {
        completion(fetchPeopleResult)
    }
    
    func fetchPeople(by name: String, completion: @escaping FetchPeopleCompletionHandler) {
        completion(fetchPeopleResult)
    }
}
