import Foundation
struct Destination : Codable, Equatable {
	let name : String?
	let type : String?
	let id : String?
	let extId : String?
	let lon : Double?
	let lat : Double?
	let time : String?
	let date : String?

	enum CodingKeys: String, CodingKey {

		case name = "name"
		case type = "type"
		case id = "id"
		case extId = "extId"
		case lon = "lon"
		case lat = "lat"
		case time = "time"
		case date = "date"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		type = try values.decodeIfPresent(String.self, forKey: .type)
		id = try values.decodeIfPresent(String.self, forKey: .id)
		extId = try values.decodeIfPresent(String.self, forKey: .extId)
		lon = try values.decodeIfPresent(Double.self, forKey: .lon)
		lat = try values.decodeIfPresent(Double.self, forKey: .lat)
		time = try values.decodeIfPresent(String.self, forKey: .time)
		date = try values.decodeIfPresent(String.self, forKey: .date)
	}

}
