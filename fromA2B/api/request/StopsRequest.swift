import Foundation

enum StopsRequest: RequestProtocol {
    
    case getStops(busStopName: String?)
    
    var path: String {
        "/v2.1/location.name"
    }
    
    var urlParams: [String: String?] {
        
        switch self {
            
        case let .getStops(busStopName):
            var params = ["format": "json"]
            
            if let busStopName {
                params["input"] = busStopName
            }
            params["accessId"] = StaticFunctions.getApiKey()
            
            return params
        }
    }
    
    var requestType: RequestType {
        .GET
    }
}
