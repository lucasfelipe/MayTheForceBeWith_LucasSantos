//
//  DoubleExtension.swift
//  MayTheForceBeWith_LucasSantos
//
//  Created by Lucas  Felipe on 14/01/2020.
//  Copyright © 2020 Lucas  Felipe. All rights reserved.
//

import Foundation

extension Double {
    static func create(with string: String?) -> Double? {
        guard let s = string else { return nil }
        return Double(s)
    }
}
