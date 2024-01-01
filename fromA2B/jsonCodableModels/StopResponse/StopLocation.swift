import Foundation
struct StopLocation : Codable, Equatable {
    static func == (lhs: StopLocation, rhs: StopLocation) -> Bool {
        lhs.extId == rhs.extId
    }
    
	let productAtStop : [ProductAtStop]?
	let timezoneOffset : Int?
	let id : String?
	let extId : String?
	let name : String?
	let lon : Double?
	let lat : Double?
	let weight : Int?
	let products : Int?

	enum CodingKeys: String, CodingKey {

		case productAtStop = "productAtStop"
		case timezoneOffset = "timezoneOffset"
		case id = "id"
		case extId = "extId"
		case name = "name"
		case lon = "lon"
		case lat = "lat"
		case weight = "weight"
		case products = "products"
	}
    
    init(name: String, extId: String) {
        
        self.name = name
        self.extId = extId

        productAtStop = nil
        timezoneOffset = nil
        id = nil
        lon = nil
        lat = nil
        weight = nil
        products = nil
    }

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		productAtStop = try values.decodeIfPresent([ProductAtStop].self, forKey: .productAtStop)
		timezoneOffset = try values.decodeIfPresent(Int.self, forKey: .timezoneOffset)
		id = try values.decodeIfPresent(String.self, forKey: .id)
		extId = try values.decodeIfPresent(String.self, forKey: .extId)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		lon = try values.decodeIfPresent(Double.self, forKey: .lon)
		lat = try values.decodeIfPresent(Double.self, forKey: .lat)
		weight = try values.decodeIfPresent(Int.self, forKey: .weight)
		products = try values.decodeIfPresent(Int.self, forKey: .products)
	}

}
