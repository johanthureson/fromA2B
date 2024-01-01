import Foundation
struct GisRoute : Codable {
	let dist : Int?
	let durS : String?
	let dirGeo : Int?

	enum CodingKeys: String, CodingKey {

		case dist = "dist"
		case durS = "durS"
		case dirGeo = "dirGeo"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		dist = try values.decodeIfPresent(Int.self, forKey: .dist)
		durS = try values.decodeIfPresent(String.self, forKey: .durS)
		dirGeo = try values.decodeIfPresent(Int.self, forKey: .dirGeo)
	}

}
