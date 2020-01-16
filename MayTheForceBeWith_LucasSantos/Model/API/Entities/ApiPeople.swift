//
//  Person.swift
//  MayTheForceBeWith_LucasSantos
//
//  Created by Lucas  Felipe on 09/01/2020.
//  Copyright © 2020 Lucas  Felipe. All rights reserved.
//

import Foundation

struct ApiPeopleResponse: InitWithDataProtocol {
    var count: Int
    var nextPage: Int
    var previousPage: Int
    var people: [ApiPeople]
    
    init(data: Data?) throws {
        guard let data = data,
            let jsonObject = try? JSONSerialization.jsonObject(with: data),
            let json = jsonObject as? [String: Any] else {
                throw NSError.createParseError()
        }
        
        try self.init(json: json)
    }
    
    init(json: Dictionary<String, Any>) throws {
        guard let count = json["count"] as? Int,
            let nextPage = ApiPeopleResponse.getPageNumberFromUrl(urlString: json["next"] as? String),
            let previousPage = ApiPeopleResponse.getPageNumberFromUrl(urlString: json["previous"] as? String),
            let people = json["results"] as? [[String: Any]]
        else {
            throw NSError.createParseError()
        }
        
        self.count = count
        self.nextPage = nextPage
        self.previousPage = previousPage
        self.people = try people.map { try ApiPeople(json: $0) }
    }
}

extension ApiPeopleResponse {
    static func getPageNumberFromUrl(urlString: String?) -> Int? {
        guard let string = urlString,
            let urlComponents = URLComponents(string: string),
            let queryParams = urlComponents.queryItems,
            let queryParamPage = queryParams.first(where: { "page" == $0.name }),
            let page = Int(queryParamPage.value ?? "0")
            else { return 0 }
        return page
    }
}

struct ApiPeople: InitWithJSONProtocol {
    let name: String?
    let height: Double?
    let mass: Double?
    let hairColor: String?
    let skinColor: String?
    let eyeColor: String?
    let birthYear: String?
    let gender: String? // TODO: Can be an enum
    let homeWorld: String?
    let films: Array<String>?
    let species: Array<String>?
    let vehicles: Array<String>?
    let starships: Array<String>?
    let created: Date?
    let edited: Date?
    let url: String?
    
    init(json: Dictionary<String, Any>) throws {
        self.name = json["name"] as? String
        self.height = Double.create(with: json["height"] as? String)
        self.mass = Double.create(with: json["mass"] as? String)
        self.hairColor = json["hair_color"] as? String
        self.skinColor = json["skin_color"] as? String
        self.eyeColor = json["eye_color"] as? String
        self.birthYear = json["birth_year"] as? String
        self.gender = json["gender"] as? String
        self.homeWorld = json["homeworld"] as? String
        self.films = json["films"] as? Array<String>
        self.species = json["species"] as? Array<String>
        self.vehicles = json["vehicles"] as? Array<String>
        self.starships = json["starships"] as? Array<String>
        self.created = Date.date(fromJSONString: json["created"] as? String)
        self.edited = Date.date(fromJSONString: json["edited"] as? String)
        self.url = json["url"] as? String
    }
    
}
