//
//  NewNetworkTests.swift
//  fromA2BTests
//
//  Created by Johan Thureson on 2023-08-31.
//

import XCTest
import SwiftUI
@testable import fromA2B


final class NewNetworkTests: XCTestCase {
    
    private var requestManager: RequestManagerProtocol?

    override func setUp() {
      super.setUp()
      requestManager = RequestManager(
        apiManager: APIManagerMock()
      )
    }
    
    func testRequestStops1() async throws {
        guard let stopResponse: StopResponse =
                try await requestManager?.perform(
                    StopsRequestMock.getStops1) else {
            XCTFail("Didn't get data from the request manager")
            return
        }
        
        let stopLocationOrCoordLocation = stopResponse.stopLocationOrCoordLocation
        
        guard let first = stopLocationOrCoordLocation?.first?.stopLocation else {
            XCTFail("nil")
            return
        }
        guard let last = stopLocationOrCoordLocation?.last?.stopLocation else {
            XCTFail("nil")
            return
        }
        XCTAssertEqual(first.name, "Logdansplan (Sundbyberg kn)")
    }
    
    func testRequestStops2() async throws {
        guard let stopResponse: StopResponse =
                try await requestManager?.perform(
                    StopsRequestMock.getStops2) else {
            XCTFail("Didn't get data from the request manager")
            return
        }
        
        let stopLocationOrCoordLocation = stopResponse.stopLocationOrCoordLocation
        
        guard let first = stopLocationOrCoordLocation?.first?.stopLocation else {
            XCTFail("nil")
            return
        }
        guard let last = stopLocationOrCoordLocation?[4].stopLocation else {
            XCTFail("nil")
            return
        }
        XCTAssertEqual(first.name, "Primusgatan (Stockholm kn)")
    }

}
