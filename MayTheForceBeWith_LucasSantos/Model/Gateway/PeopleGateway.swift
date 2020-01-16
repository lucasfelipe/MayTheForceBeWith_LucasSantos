//
//  PeopleService.swift
//  MayTheForceBeWith_LucasSantos
//
//  Created by Lucas  Felipe on 14/01/2020.
//  Copyright © 2020 Lucas  Felipe. All rights reserved.
//

import Foundation

typealias FetchPeopleCompletionHandler = (_ people: Result<ApiPeopleResponse>) -> Void

protocol PeopleGateway {
    func fetchPeople(in page: Int, completion: @escaping FetchPeopleCompletionHandler)
    
    func fetchPeople(by name: String, completion: @escaping FetchPeopleCompletionHandler)
}
