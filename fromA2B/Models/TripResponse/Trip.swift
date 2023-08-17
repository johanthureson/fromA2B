/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Trip : Codable, Identifiable {
    
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