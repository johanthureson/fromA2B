import Foundation

public struct StopResponse : Codable {
    
	let stopLocationOrCoordLocation : [StopLocationOrCoordLocation]?
	let technicalMessages : TechnicalMessages?
	let serverVersion : String?
	let dialectVersion : String?
	let requestId : String?

	enum CodingKeys: String, CodingKey {

		case stopLocationOrCoordLocation = "stopLocationOrCoordLocation"
		case technicalMessages = "TechnicalMessages"
		case serverVersion = "serverVersion"
		case dialectVersion = "dialectVersion"
		case requestId = "requestId"
	}

	public init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		stopLocationOrCoordLocation = try values.decodeIfPresent([StopLocationOrCoordLocation].self, forKey: .stopLocationOrCoordLocation)
		technicalMessages = try values.decodeIfPresent(TechnicalMessages.self, forKey: .technicalMessages)
		serverVersion = try values.decodeIfPresent(String.self, forKey: .serverVersion)
		dialectVersion = try values.decodeIfPresent(String.self, forKey: .dialectVersion)
		requestId = try values.decodeIfPresent(String.self, forKey: .requestId)
	}

}

