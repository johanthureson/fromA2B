//
//  ContentView.swift
//  fromA2B
//
//  Created by Johan Thureson on 2023-06-06.
//

/*
api_468339455
https://api.lyko.tech/v2/docs/
 
 curl -X 'GET' \
   'https://api.lyko.tech/v2/addresses?text=12%20Rue%20Sainte-Foy%2C%2075002%20Paris%2C%20France&lat=48.868714&lng=2.351026&limit=10&locale=en' \
   -H 'accept: application/json' -H 'X-Api-Key: api_468339455'

 curl -X 'GET' \
   'https://api.lyko.tech/v2/addresses?lat=48.868714&lng=2.351026&limit=10&locale=en' \
   -H 'accept: application/json' -H 'X-Api-Key: api_468339455'

 curl -X 'GET' \
   'https://api.lyko.tech/v2/addresses?lat=48.868714&lng=2.361026&limit=10&locale=en' \
   -H 'accept: application/json' -H 'X-Api-Key: api_468339455'
 
 
 curl -X 'GET' \
   'https://api.lyko.tech/v2/journeys?from=48.868714%2C2.351026&to=48.858508%2C2.294782&via=123%2C456&date=2023-07-22T14%3A16%3A52.457Z&dateType=DEPARTURE&passengers=1&modes=FOOT&modes=SCOOTER&modes=MOTORCYCLE&modes=CAR&modes=UNKNOWN&modes=TRANSIT_TRAMWAY&modes=TRANSIT_METRO&modes=TRANSIT_TRAIN&modes=TRANSIT_BUS&modes=TRANSIT_FERRY&modes=TRANSIT_AERIAL_LIFT&modes=TRANSIT_FUNICULAR&modes=TRANSIT_TROLLEYBUS&modes=TRANSIT_MONORAIL&modes=PARKING_PAID&modes=PARKING_FREE&operators=all&datasets=&sort=FASTEST&reductionCards=train_card_fr_01&maxDistancesByLeg=MOTORCYCLE%3D2000%2CFOOT%3D1000' \
 -H 'accept: application/json' -H 'X-Api-Key: api_468339455'

 curl -X 'GET' \
   'https://api.lyko.tech/v2/journeys?from=48.868714%2C2.351026&to=48.858508%2C2.294782&date=2023-07-22T14%3A16%3A52.457Z&dateType=DEPARTURE&passengers=1&modes=FOOT&modes=SCOOTER&modes=MOTORCYCLE&modes=CAR&modes=UNKNOWN&modes=TRANSIT_TRAMWAY&modes=TRANSIT_METRO&modes=TRANSIT_TRAIN&modes=TRANSIT_BUS&modes=TRANSIT_FERRY&modes=TRANSIT_AERIAL_LIFT&modes=TRANSIT_FUNICULAR&modes=TRANSIT_TROLLEYBUS&modes=TRANSIT_MONORAIL&modes=PARKING_PAID&modes=PARKING_FREE&operators=all&datasets=&sort=FASTEST&reductionCards=train_card_fr_01' \
 -H 'accept: application/json' -H 'X-Api-Key: api_468339455'
 
 curl -X 'GET' \
   'https://api.lyko.tech/v2/journeys?from=48.868714%2C2.351026&to=48.858508%2C2.294782&date=2023-07-22T14%3A16%3A52.457Z&dateType=DEPARTURE&passengers=1&modes=FOOT&modes=UNKNOWN&modes=TRANSIT_TRAMWAY&modes=TRANSIT_METRO&modes=TRANSIT_TRAIN&modes=TRANSIT_BUS&modes=TRANSIT_FERRY&modes=TRANSIT_AERIAL_LIFT&modes=TRANSIT_FUNICULAR&modes=TRANSIT_TROLLEYBUS&modes=TRANSIT_MONORAIL&modes=PARKING_PAID&modes=PARKING_FREE&operators=all&datasets=&sort=FASTEST&reductionCards=train_card_fr_01' \
 -H 'accept: application/json' -H 'X-Api-Key: api_468339455'
 
 Majeldsvägen
 59.37367
 17.97705
 
 till Cirksugränd 1
 59.42606
 17.95174
 
 curl -X 'GET' \
   'https://api.lyko.tech/v2/journeys?from=59.37367%2C17.97705&to=59.42606%2C17.95174&date=2023-07-22T14%3A16%3A52.457Z&dateType=DEPARTURE&passengers=1&modes=FOOT&modes=UNKNOWN&modes=TRANSIT_TRAMWAY&modes=TRANSIT_METRO&modes=TRANSIT_TRAIN&modes=TRANSIT_BUS&modes=TRANSIT_FERRY&modes=TRANSIT_AERIAL_LIFT&modes=TRANSIT_FUNICULAR&modes=TRANSIT_TROLLEYBUS&modes=TRANSIT_MONORAIL&modes=PARKING_PAID&modes=PARKING_FREE&operators=all&datasets=&sort=FASTEST&reductionCards=train_card_fr_01' \
 -H 'accept: application/json' -H 'X-Api-Key: api_468339455'
 
 bara kommunalt i frankrike:
 curl -X 'GET' \
   'https://api.lyko.tech/v2/journeys?from=48.868714%2C2.351026&to=48.858508%2C2.294782&date=2023-07-22T14%3A16%3A52.457Z&dateType=DEPARTURE&passengers=1&modes=FOOT&modes=UNKNOWN&modes=TRANSIT_TRAMWAY&modes=TRANSIT_METRO&modes=TRANSIT_TRAIN&modes=TRANSIT_BUS&modes=TRANSIT_FERRY&modes=TRANSIT_AERIAL_LIFT&modes=TRANSIT_FUNICULAR&modes=TRANSIT_TROLLEYBUS&modes=TRANSIT_MONORAIL&modes=PARKING_PAID&modes=PARKING_FREE&operators=all&datasets=&sort=FASTEST&reductionCards=train_card_fr_01' \
 -H 'accept: application/json' -H 'X-Api-Key: api_468339455'
*/

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                    } label: {
                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
