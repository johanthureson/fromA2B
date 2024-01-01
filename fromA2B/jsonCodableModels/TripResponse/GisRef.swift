import Foundation
struct GisRef : Codable {
	let ref : String?

	enum CodingKeys: String, CodingKey {

		case ref = "ref"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		ref = try values.decodeIfPresent(String.self, forKey: .ref)
	}

}
