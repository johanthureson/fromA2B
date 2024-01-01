import Foundation

struct TripResponse : Codable {
    
	let trip : [Trip]?
	let resultStatus : ResultStatus?
	let technicalMessages : TechnicalMessages?
	let serverVersion : String?
	let dialectVersion : String?
	let planRtTs : String?
	let requestId : String?
	let scrB : String?
	let scrF : String?

	enum CodingKeys: String, CodingKey {

		case trip = "Trip"
		case resultStatus = "ResultStatus"
		case technicalMessages = "TechnicalMessages"
		case serverVersion = "serverVersion"
		case dialectVersion = "dialectVersion"
		case planRtTs = "planRtTs"
		case requestId = "requestId"
		case scrB = "scrB"
		case scrF = "scrF"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		trip = try values.decodeIfPresent([Trip].self, forKey: .trip)
		resultStatus = try values.decodeIfPresent(ResultStatus.self, forKey: .resultStatus)
		technicalMessages = try values.decodeIfPresent(TechnicalMessages.self, forKey: .technicalMessages)
		serverVersion = try values.decodeIfPresent(String.self, forKey: .serverVersion)
		dialectVersion = try values.decodeIfPresent(String.self, forKey: .dialectVersion)
		planRtTs = try values.decodeIfPresent(String.self, forKey: .planRtTs)
		requestId = try values.decodeIfPresent(String.self, forKey: .requestId)
		scrB = try values.decodeIfPresent(String.self, forKey: .scrB)
		scrF = try values.decodeIfPresent(String.self, forKey: .scrF)
	}

}
