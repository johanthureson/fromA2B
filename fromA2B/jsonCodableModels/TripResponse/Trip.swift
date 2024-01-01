import Foundation
struct Trip : Codable, Identifiable, Equatable {
    static func == (lhs: Trip, rhs: Trip) -> Bool {
        lhs.origin == rhs.origin &&
        lhs.destination == rhs.destination &&
        lhs.legList == rhs.legList
    }
    
    
    var id = UUID()

	let origin : Origin?
	let destination : Destination?
	let serviceDays : [ServiceDays]?
	let legList : LegList?
	let calculation : String?
	let tripStatus : TripStatus?
	let idx : Int?
	let tripId : String?
	let ctxRecon : String?
	let duration : String?
	let rtDuration : String?
	let checksum : String?

	enum CodingKeys: String, CodingKey {

		case origin = "Origin"
		case destination = "Destination"
		case serviceDays = "ServiceDays"
		case legList = "LegList"
		case calculation = "calculation"
		case tripStatus = "TripStatus"
		case idx = "idx"
		case tripId = "tripId"
		case ctxRecon = "ctxRecon"
		case duration = "duration"
		case rtDuration = "rtDuration"
		case checksum = "checksum"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		origin = try values.decodeIfPresent(Origin.self, forKey: .origin)
		destination = try values.decodeIfPresent(Destination.self, forKey: .destination)
		serviceDays = try values.decodeIfPresent([ServiceDays].self, forKey: .serviceDays)
		legList = try values.decodeIfPresent(LegList.self, forKey: .legList)
		calculation = try values.decodeIfPresent(String.self, forKey: .calculation)
		tripStatus = try values.decodeIfPresent(TripStatus.self, forKey: .tripStatus)
		idx = try values.decodeIfPresent(Int.self, forKey: .idx)
		tripId = try values.decodeIfPresent(String.self, forKey: .tripId)
		ctxRecon = try values.decodeIfPresent(String.self, forKey: .ctxRecon)
		duration = try values.decodeIfPresent(String.self, forKey: .duration)
		rtDuration = try values.decodeIfPresent(String.self, forKey: .rtDuration)
		checksum = try values.decodeIfPresent(String.self, forKey: .checksum)
	}

}
