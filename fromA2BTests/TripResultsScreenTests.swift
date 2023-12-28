//
//  TripResultsScreenTests.swift
//  fromA2BTests
//
//  Created by Johan Thureson on 2023-08-25.
//

import XCTest
import Mocker

final class TripResultsScreenTests: XCTestCase {
    
    /// It should correctly fetch and parse the user.
    func testUserFetching() {
        
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        let sessionManager = URLSession(configuration: configuration)

        let apiEndpoint = URL(string: "https://api.resrobot.se")!
        // "https://api.resrobot.se/v2.1/trip?format=json&originId=740066612&destId=740046109&passlist=true&showPassingPoints=true&accessId=\(StaticFunctions.getApiKey())")!
        let expectedTrips = TripResponse.tripResponse!.trip!
        let requestExpectation = expectation(description: "Request should finish")

        let mockedData = try! JSONEncoder().encode(expectedTrips)
        let mock = Mock(url: apiEndpoint, dataType: .json, statusCode: 200, data: [.get: mockedData])
        mock.register()
        
        sessionManager.dataTask(with: apiEndpoint) { (data, response, error) in
            defer { requestExpectation.fulfill() }
            do {
                if let error = error {
                    throw error
                }

                let trips = try JSONDecoder().decode([Trip].self, from: data!)
                XCTAssertEqual(trips, expectedTrips)
            } catch {
                XCTFail(error.localizedDescription)
            }
        }.resume()

        wait(for: [requestExpectation], timeout: 10.0)
    }
}
