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
