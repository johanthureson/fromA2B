//
//  TripResultsViewTests.swift
//  fromA2BTests
//
//  Created by Johan Thureson on 2023-08-25.
//

import XCTest
import Mocker
import Alamofire

final class TripResultsViewTests: XCTestCase {
    func testUserFetchingURLSession() {
        
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        let sessionManager = Session(configuration: configuration)

        let apiEndpoint = URL(string: "https://api.resrobot.se")!// "https://api.resrobot.se/v2.1/trip?format=json&originId=740066612&destId=740046109&passlist=true&showPassingPoints=true&accessId=661da78d-bf7c-4b44-8f33-c02ebc44228a")!
        let expectedTrips = TripResponse.tripResponse!.trip!
        let requestExpectation = expectation(description: "Request should finish")

        let mockedData = try! JSONEncoder().encode(expectedTrips)
        let mock = Mock(url: apiEndpoint, dataType: .json, statusCode: 200, data: [.get: mockedData])
        mock.register()
        
        sessionManager
            .request(apiEndpoint)
            .responseDecodable(of: [Trip].self) { (response) in
                XCTAssertNil(response.error)
                XCTAssertEqual(response.value, expectedTrips)
                requestExpectation.fulfill()
            }.resume()

        wait(for: [requestExpectation], timeout: 10.0)
    }
}
