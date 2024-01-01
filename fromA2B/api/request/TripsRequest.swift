import Foundation

enum TripsRequest: RequestProtocol {
    
    case getTrips(originId: String?, destId: String?)
    
    var path: String {
        "/v2.1/trip"
    }
    
    var urlParams: [String: String?] {
        
        switch self {
            
        case let .getTrips(originId, destId):
            var params = ["format": "json"]
            if let originId {
                params["originId"] = originId
            }
            if let destId {
                params["destId"] = destId
            }
            params["passlist"] = "true"
            params["showPassingPoints"] = "true"
            params["accessId"] = StaticFunctions.getApiKey()
            return params
        }
    }
    
    var requestType: RequestType {
        .GET
    }
}
