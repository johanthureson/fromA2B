//
//  NetworkAPITests.swift
//  fromA2BTests
//
//  Created by Johan Thureson on 2023-08-29.
//

import XCTest
import Mocker
import Alamofire

final class NetworkAPITests: XCTestCase {
    
    /// It should correctly fetch and parse the user.
    func testUserFetching() {
        
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        let sessionManager = Session(configuration: configuration)
        
        let apiEndpoint = URL(string: "https://api.resrobot.se")!
        // "https://api.resrobot.se/v2.1/trip?format=json&originId=740066612&destId=740046109&passlist=true&showPassingPoints=true&accessId=\(StaticFunctions.getApiKey())")")!
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

//
//    // test getStops
//    func testGetStops() async throws {
//        let stops = await NetworkAPI.getStops(busStopName: "Kungsgatan")
//        XCTAssertNotNil(stops)
//        XCTAssertEqual(stops?.count, 10)
//        XCTAssertEqual(stops?.first?.stopLocation?.name, "Kungsgatan, Göteborg")
//    }
//    
//}
