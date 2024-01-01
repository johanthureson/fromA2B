import Foundation
struct TripStatus : Codable {
	let hintCode : Int?
	let unsharp : Bool?

	enum CodingKeys: String, CodingKey {

		case hintCode = "hintCode"
		case unsharp = "unsharp"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		hintCode = try values.decodeIfPresent(Int.self, forKey: .hintCode)
		unsharp = try values.decodeIfPresent(Bool.self, forKey: .unsharp)
	}

}
