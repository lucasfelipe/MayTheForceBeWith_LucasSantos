//
//  PeopleTableViewControllerTests.swift
//  MayTheForceBeWith_LucasSantosTests
//
//  Created by Lucas  Felipe on 16/01/2020.
//  Copyright © 2020 Lucas  Felipe. All rights reserved.
//

import XCTest
@testable import MayTheForceBeWith_LucasSantos

class PeopleTableViewControllerTests: XCTestCase {
    
    var viewController: PeopleTableViewController!
    
    var configSessionStub = ApiSessionConfigStub()

    override func setUp() {
        viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "PeopleTableViewController") as? PeopleTableViewController
        
    }

    override func tearDown() {
        viewController = nil
    }

    func testViewDidLoadShouldPresentPeople() {
        let jsonMock = """
            {
                "count": 87,
                "next": "https://swapi.co/api/people/?page=2",
                "results": [{
                    "name": "Luke Skywalker",
                    "height": "172",
                    "mass": "77",
                    "hair_color": "blond",
                    "skin_color": "fair",
                    "eye_color": "blue",
                    "birth_year": "19BBY",
                    "gender": "male"
                }]
           }
        """
        let expectedJSONData = jsonMock.data(using: .utf8)
        let expectedResponse = HTTPURLResponse(statusCode: 200)
        guard let responseMock = try? ApiPeopleResponse(data: expectedJSONData) else {
            XCTFail("Json Mock Data Invalid")
            return
        }
    
        self.configSessionStub.enqueue(response: (data: expectedJSONData, response: expectedResponse, error: nil))
        
         let viewDidLoadExpectation = expectation(description: "Execute View Did Load People")
         viewController.apiClient = ApiClientStub(sessionConfiguration: self.configSessionStub, expectation: viewDidLoadExpectation)
        
        viewController.viewDidLoad()
        
        waitForExpectations(timeout: 1, handler: nil)
        
        XCTAssertEqual(responseMock.people.count, viewController.peopleCount, "People Count is not the same as expected")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
