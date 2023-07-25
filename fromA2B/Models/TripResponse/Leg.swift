/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Leg : Codable {
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