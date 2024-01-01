import Foundation
struct TechnicalMessages : Codable {
	let technicalMessage : [TechnicalMessage]?

	enum CodingKeys: String, CodingKey {

		case technicalMessage = "TechnicalMessage"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		technicalMessage = try values.decodeIfPresent([TechnicalMessage].self, forKey: .technicalMessage)
	}

}
