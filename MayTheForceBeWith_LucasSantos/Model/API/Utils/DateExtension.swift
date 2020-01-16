//
//  DateExtension.swift
//  MayTheForceBeWith_LucasSantos
//
//  Created by Lucas  Felipe on 13/01/2020.
//  Copyright © 2020 Lucas  Felipe. All rights reserved.
//

import Foundation

extension Date {
    static func date(fromJSONString date: String?) -> Date? {
        guard let date = date else { return nil }
        return createFormatter().date(from: date)
    }
    
    static func string(from date: Date?) -> String {
        guard let date = date else { return "Unknown" }
        return createFormatter().string(from: date)
    }
    
    private static func createFormatter() -> DateFormatter {
        let dtFormat = DateFormatter()
        dtFormat.dateFormat = "yyyy-MM-dd HH:mm"
        return dtFormat
    }
}
