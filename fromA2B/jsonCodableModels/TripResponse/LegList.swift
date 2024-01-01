import Foundation
struct LegList : Codable, Equatable {
    static func == (lhs: LegList, rhs: LegList) -> Bool {
        lhs.leg == rhs.leg
    }
    
	let leg : [Leg]?

	enum CodingKeys: String, CodingKey {

		case leg = "Leg"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		leg = try values.decodeIfPresent([Leg].self, forKey: .leg)
	}

}
