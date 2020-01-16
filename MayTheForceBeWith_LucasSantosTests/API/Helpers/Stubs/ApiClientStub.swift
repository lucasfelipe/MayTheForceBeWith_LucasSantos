//
//  ApiClientStub.swift
//  MayTheForceBeWith_LucasSantosTests
//
//  Created by Lucas  Felipe on 16/01/2020.
//  Copyright © 2020 Lucas  Felipe. All rights reserved.
//

import Foundation
import XCTest
@testable import MayTheForceBeWith_LucasSantos

class ApiClientStub: ApiClient {
    
    let sessionConfiguration: ApiSessionConfigStub
    
    var expectation: XCTestExpectation
    
    init(sessionConfiguration: ApiSessionConfigStub, expectation: XCTestExpectation) {
        self.sessionConfiguration = sessionConfiguration
        self.expectation = expectation
    }
    
   func execute<T>(request: ApiRequest, completionHandler: @escaping (_ result: Result<ApiResponse<T>>) -> Void) {
        
    self.sessionConfiguration.dataTask(with: request.urlRequest, completionHandler: { (data, response, error) in
        
        guard let result = response as? HTTPURLResponse else {
            completionHandler(.fail(NetworkRequestError(error: error)))
            return
        }
        
        let successRange = 200...299
        if (successRange.contains(result.statusCode)) {
            do {
                let response = try ApiResponse<T>(data: data, httpUrlResponse: result)
                completionHandler(.success(response))
            } catch {
                completionHandler(.fail(error))
            }
            
            self.expectation.fulfill()
        }
        }).resume()
    }
    
    
}
