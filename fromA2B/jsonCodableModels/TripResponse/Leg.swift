import Foundation
struct Leg : Codable, Identifiable, Equatable {
    static func == (lhs: Leg, rhs: Leg) -> Bool {
        lhs.origin == rhs.origin &&
        lhs.destination == rhs.destination
    }
    
    
    var id = UUID()
    
	let origin : Origin?
	let destination : Destination?
	let gisRef : GisRef?
	let gisRoute : GisRoute?
	let product : [Product]?
	let idx : Int?
	let name : String?
	let type : String?
	let duration : String?
	let dist : Int?

	enum CodingKeys: String, CodingKey {

		case origin = "Origin"
		case destination = "Destination"
		case gisRef = "GisRef"
		case gisRoute = "GisRoute"
		case product = "Product"
		case idx = "idx"
		case name = "name"
		case type = "type"
		case duration = "duration"
		case dist = "dist"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		origin = try values.decodeIfPresent(Origin.self, forKey: .origin)
		destination = try values.decodeIfPresent(Destination.self, forKey: .destination)
		gisRef = try values.decodeIfPresent(GisRef.self, forKey: .gisRef)
		gisRoute = try values.decodeIfPresent(GisRoute.self, forKey: .gisRoute)
		product = try values.decodeIfPresent([Product].self, forKey: .product)
		idx = try values.decodeIfPresent(Int.self, forKey: .idx)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		type = try values.decodeIfPresent(String.self, forKey: .type)
		duration = try values.decodeIfPresent(String.self, forKey: .duration)
		dist = try values.decodeIfPresent(Int.self, forKey: .dist)
	}

}
