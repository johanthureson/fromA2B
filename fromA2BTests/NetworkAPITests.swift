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
    
    
    private var sut: NetworkManager!
    
    override func setUp() {
        super.setUp()
        
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockURLProtocol.self] + (configuration.protocolClasses ?? [])
        let sessionManager = Session(configuration: configuration)

//        let manager: SessionManager = {
//            let configuration: URLSessionConfiguration = {
//                let configuration = URLSessionConfiguration.default
//                configuration.protocolClasses = [MockURLProtocol.self]
//                return configuration
//            }()
//            
//            return SessionManager(configuration: configuration)
//        }()
        sut = NetworkManager(sessionManager: sessionManager)
    }
    
    override func tearDown() {
        super.tearDown()
        
        sut = nil
    }
    
    func testStatusCode200ReturnsStatusCode200() async {
        // given
        MockURLProtocol.responseWithStatusCode(code: 200)
        
//        let expectation = XCTestExpectation(description: "Performs a request")
        
        // when
        let result = await NetworkAPI.getStops(busStopName: "Logdansplan", networkManager: sut)
//        sut.login(username: "username", password: "password") { (result) in
//            XCTAssertEqual(result.response?.statusCode, 200)
//            expectation.fulfill()
//        }
//        
//        // then
//        wait(for: [expectation], timeout: 3)
        //
//        XCTAssertEqual(result.response?.statusCode, 200)

        XCTAssertEqual(result?.count, 10)
    }

    
    
    /*
    // test getStops
    func testGetStops() async throws {
        let stops = await NetworkAPI.getStops(busStopName: "Kungsgatan")
        XCTAssertNotNil(stops)
        XCTAssertEqual(stops?.count, 10)
        XCTAssertEqual(stops?.first?.stopLocation?.name, "Kungsgatan, Göteborg")
    }
    */

    /*
    /// It should correctly fetch and parse the user.
    func testUserFetching() {
        
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
    */
}
