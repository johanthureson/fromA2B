import Foundation
struct ResultStatus : Codable {
	let timeDiffCritical : Bool?

	enum CodingKeys: String, CodingKey {

		case timeDiffCritical = "timeDiffCritical"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		timeDiffCritical = try values.decodeIfPresent(Bool.self, forKey: .timeDiffCritical)
	}

}
