import Foundation
struct ProductAtStop : Codable {
	let icon : Icon?
	let cls : String?

	enum CodingKeys: String, CodingKey {

		case icon = "icon"
		case cls = "cls"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		icon = try values.decodeIfPresent(Icon.self, forKey: .icon)
		cls = try values.decodeIfPresent(String.self, forKey: .cls)
	}

}
