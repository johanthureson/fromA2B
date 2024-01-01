import Foundation
struct Product : Codable {
	let icon : Icon?
	let name : String?
	let internalName : String?

	enum CodingKeys: String, CodingKey {

		case icon = "icon"
		case name = "name"
		case internalName = "internalName"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		icon = try values.decodeIfPresent(Icon.self, forKey: .icon)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		internalName = try values.decodeIfPresent(String.self, forKey: .internalName)
	}

}
