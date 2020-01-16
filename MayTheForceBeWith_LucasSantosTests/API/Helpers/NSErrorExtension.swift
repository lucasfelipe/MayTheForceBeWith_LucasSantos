//
//  NSErrorExtension.swift
//  MayTheForceBeWith_LucasSantosTests
//
//  Created by Lucas  Felipe on 16/01/2020.
//  Copyright © 2020 Lucas  Felipe. All rights reserved.
//

import Foundation

extension NSError {
    static func createError(withMessage message: String) -> NSError {
        return NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: message])
    }
}
