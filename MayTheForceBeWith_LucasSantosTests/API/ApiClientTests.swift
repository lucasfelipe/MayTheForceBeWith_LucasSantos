//
//  ApiClientTests.swift
//  MayTheForceBeWith_LucasSantosTests
//
//  Created by Lucas  Felipe on 16/01/2020.
//  Copyright © 2020 Lucas  Felipe. All rights reserved.
//

import XCTest
@testable import MayTheForceBeWith_LucasSantos

class ApiClientTests: XCTestCase {
    
    let configSessionStub = ApiSessionConfigStub()
    
    var apiClient: ApiClientImpl!

    override func setUp() {
        self.apiClient = ApiClientImpl(sessionConfiguration: configSessionStub)
    }

    override func tearDown() {
        
    }

    func testApiResponseRequestSuccessful() {
        let expectedUtf8String = "{\"Key\" : \"Value\"}"
        let expectedData = expectedUtf8String.data(using: .utf8)
        let expectedResponse = HTTPURLResponse(statusCode: 200)
        
        configSessionStub.enqueue(response: (data: expectedData, response: expectedResponse, error: nil))
        
        let completionHandlerExpectation = expectation(description: "Execute API")
        
        self.apiClient.execute(request: TestDoubleRequest()) { (result: Result<ApiResponse<TestDoubleApiEntity>>) in
            
            guard let response = try? result.answered() else {
                XCTFail("A successful response should've been returned")
                return
            }
            
            XCTAssertEqual(expectedUtf8String, response.entity.utf8String, "The string is not the expected one")
            XCTAssertTrue(expectedResponse === response.httpUrlResponse, "The http response is not the expected one")
            XCTAssertEqual(expectedData?.base64EncodedString(), response.data?.base64EncodedString(), "Data doesn't match")
            
            completionHandlerExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testApiResponseRequestError() {
        let expectedUtf8String = "{\"Key\" : \"Value\"}"
        let expectedData = expectedUtf8String.data(using: .utf8)
        let expected400Response = HTTPURLResponse(statusCode: 400)
        
        self.configSessionStub.enqueue(response: (data: expectedData, response: expected400Response, error: nil))
        
        let completionHandlerExpectation = expectation(description: "Execute API completion")
        
        apiClient.execute(request: TestDoubleRequest()) { (result: Result<ApiResponse<TestDoubleApiEntity>>) in
            do {
                let _ = try result.answered()
            } catch let error as ApiError {
                XCTAssertTrue(expected400Response === error.httpUrlResponse, "The http response is not the expected one")
                XCTAssertEqual(expectedData?.base64EncodedString(), error.data?.base64EncodedString(), "Data doesn't match")
            } catch {
                XCTFail("Expected api error to be thrown")
            }
            
            completionHandlerExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

private struct TestDoubleRequest: ApiRequest {
    var urlRequest: URLRequest {
        return URLRequest(url: URL.testUrl)
    }
}

private struct TestDoubleApiEntity: InitWithDataProtocol {
    var utf8String: String
    
    init(data: Data?) throws {
        utf8String = String(data: data!, encoding: .utf8)!
    }
}
