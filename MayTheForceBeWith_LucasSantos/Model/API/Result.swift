//
//  Result.swift
//  MayTheForceBeWith_LucasSantos
//
//  Created by Lucas  Felipe on 13/01/2020.
//  Copyright © 2020 Lucas  Felipe. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case fail(Error)
    
    public func answered() throws -> T {
        switch self {
        case let .success(value):
            return value
        case let .fail(error):
            throw error
        }
    }
}
