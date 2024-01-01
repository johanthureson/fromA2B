import Foundation
@testable import fromA2B

enum StopsRequestMock: RequestProtocol {
  case getStops

  var requestType: RequestType {
    return .GET
  }

  var path: String {
    guard let path = Bundle.main.path(forResource: "location_origin", ofType: "json") else { return "" }
    return path
  }
}


enum TripsRequestMock: RequestProtocol {
  case getTrips

  var requestType: RequestType {
    return .GET
  }

  var path: String {
    guard let path = Bundle.main.path(forResource: "trip", ofType: "json") else { return "" }
    return path
  }
}
