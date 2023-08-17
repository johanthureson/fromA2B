//
//  TripDetailsView.swift
//  fromA2B
//
//  Created by Johan Thureson on 2023-07-22.
//

import SwiftUI

class ContentViewViewModel: ObservableObject {
    @MainActor @Published var errorMessage = ""
    @MainActor @Published var appliances: [Appliance] = []

    func fetchAppliances() async {
        await MainActor.run {
            self.errorMessage = ""
        }
        if let res = await NetworkAPI.getAppliances() {
            await MainActor.run {
                self.appliances = res
            }
        } else {
            await MainActor.run {
                self.errorMessage = "Fetch data failed"
            }
        }
    }
}

struct TripDetailsView: View {
    @StateObject var viewModel = ContentViewViewModel()

    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            if viewModel.errorMessage != "" {
                Text(viewModel.errorMessage)
            }
            Button("Fetch") {
                Task {
                    await viewModel.fetchAppliances()
                }
            }
            List {
                ForEach(viewModel.appliances, id: \.id) { item in
                    Text("\(item.brand) - \(item.equipment)")
                }
            }
            .listStyle(.inset)
        }
        .padding()
        .onAppear {
            Task {
                await viewModel.fetchAppliances()
            }
        }
    }
}

/*
struct TripDetailsView: View {
    
    var trip: Trip

    var body: some View {
        
        
        VStack {
            fromToText(trip: trip)
                .padding()
                .font(.title2)
            
            ForEach(trip.legList?.leg ?? []) { leg in
                
                VStack {
                    timeToTime(leg: leg)
                    fromToText(leg: leg)
                }
                .padding()

            }
        }
        
    }
        
    private func timeToTime(leg: Leg) -> some View {
        
        let fromTime = leg.origin?.time?.dropLast(3) ?? ""
        let toTime = leg.destination?.time?.dropLast(3) ?? ""
        return Text(fromTime + "-" + toTime)
    }

    private func fromToText(trip: Trip) -> some View {
        
        let fromText = trip.origin?.name ?? ""
        let toText = trip.destination?.name ?? ""
        return Text(fromText + " -> " + toText)
    }
    
    private func fromToText(leg: Leg) -> some View {
        
        let fromText = leg.origin?.name ?? ""
        let toText = leg.destination?.name ?? ""
        return Text(fromText + " -> " + toText)
    }

}

#Preview {
    TripDetailsView(trip: TripResponse.tripResponse!.trip!.first!)
}
*/
