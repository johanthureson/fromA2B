import Foundation
struct ServiceDays : Codable {
	let planningPeriodBegin : String?
	let planningPeriodEnd : String?
	let sDaysR : String?
	let sDaysB : String?

	enum CodingKeys: String, CodingKey {

		case planningPeriodBegin = "planningPeriodBegin"
		case planningPeriodEnd = "planningPeriodEnd"
		case sDaysR = "sDaysR"
		case sDaysB = "sDaysB"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		planningPeriodBegin = try values.decodeIfPresent(String.self, forKey: .planningPeriodBegin)
		planningPeriodEnd = try values.decodeIfPresent(String.self, forKey: .planningPeriodEnd)
		sDaysR = try values.decodeIfPresent(String.self, forKey: .sDaysR)
		sDaysB = try values.decodeIfPresent(String.self, forKey: .sDaysB)
	}

}
