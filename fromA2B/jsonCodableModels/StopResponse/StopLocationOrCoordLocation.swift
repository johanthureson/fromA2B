import Foundation
struct StopLocationOrCoordLocation : Codable, Identifiable {
    
    var id = UUID()
    
	let stopLocation : StopLocation?

	enum CodingKeys: String, CodingKey {

		case stopLocation = "StopLocation"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		stopLocation = try values.decodeIfPresent(StopLocation.self, forKey: .stopLocation)
	}

}
