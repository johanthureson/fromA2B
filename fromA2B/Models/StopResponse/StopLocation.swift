/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct StopLocation : Codable, Observable {
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
