//
//  PeopleExtension.swift
//  MayTheForceBeWith_LucasSantosTests
//
//  Created by Lucas  Felipe on 16/01/2020.
//  Copyright © 2020 Lucas  Felipe. All rights reserved.
//

import Foundation
@testable import MayTheForceBeWith_LucasSantos

extension ApiPeople {
    static func createAnArray(numberOfElements: Int = 2) -> [ApiPeople] {
        var people = [ApiPeople]()
        
        for index in 0..<numberOfElements {
            let person = createPerson(index)
            people.append(person)
        }
        
        return people
    }
    
    static func createPerson(_ index: Int) -> ApiPeople {
        let json = [
            "name": "Person \(index)"
        ]
        
        let people = try! ApiPeople(json: json)
        return people
    }
}
