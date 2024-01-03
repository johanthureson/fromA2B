//
//  TripResultsScreenView.swift
//  fromA2B
//
//  Created by Johan Thureson on 2023-07-22.
//

import SwiftUI
import Observation
import SwiftData

struct TripResultsScreenView: View {
    
    @Environment(\.modelContext) private var modelContext
    @State var viewModel: TripResultsScreenViewModel
    
    var body: some View {
        
        VStack(spacing: 16) {
            
            tripsList()
            
        }
        .padding()
        .onAppear {
            if (ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == nil) {
                Task {
                    await viewModel.fetchTrips()
                    viewModel.updateSearchHistory(modelContext: modelContext)
                }
            }
        }
        .overlay {
            if viewModel.isLoading {
                ProgressView("Finding Trips near you...")
            }
        }
        .alert(isPresented: Binding<Bool>(
            get: { viewModel.errorMessage != nil },
            set: { _ in viewModel.errorMessage = nil }
        )) {
            Alert(
                title: Text("Error"),
                message: Text(viewModel.errorMessage ?? "Unknown error"),
                dismissButton: .default(Text("OK"))
            )
        }

    }
    
    
    
    // MARK: - body views
    
    private func tripsList() -> some View {
        List {
            ForEach(viewModel.trips) { trip in
                
                NavigationLink(destination: TripDetailsScreenView(trip: trip) ) {
                    VStack {
                        fromToText(trip: trip)
                            .padding()
                            .font(.title2)
                        
                        ForEach(trip.legList?.leg ?? []) { leg in
                            fromToText(leg: leg)
                                .padding()
                        }
                    }
                }
            }
        }
        .listStyle(.inset)
    }
    
    
    
    // MARK: - subviews

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



// MARK: - Preview

#if DEBUG

#Preview {
    TripResultsScreenView(
        viewModel: TripResultsScreenViewModel(
            trips: TripResponse.tripResponse!.trip!
        )
    )
}

#Preview {
    TripResultsScreenView(
        viewModel: TripResultsScreenViewModel(
            errorMessage: "Error message"
        )
    )
}

#endif
