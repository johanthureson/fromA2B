import Foundation
struct Icon : Codable {
	let res : String?

	enum CodingKeys: String, CodingKey {

		case res = "res"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		res = try values.decodeIfPresent(String.self, forKey: .res)
	}

}
