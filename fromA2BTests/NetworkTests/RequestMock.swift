import Foundation
@testable import fromA2B

enum StopsRequestMock: RequestProtocol {
    case getStops1
    case getStops2

  var requestType: RequestType {
    return .GET
  }

  var path: String {
      switch self {
      case .getStops1:
          guard let path = Bundle.main.path(forResource: "location_origin", ofType: "json") else { return "" }
          return path
      default:
          guard let path = Bundle.main.path(forResource: "location_destination", ofType: "json") else { return "" }
          return path
      }
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
