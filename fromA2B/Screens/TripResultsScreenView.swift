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
    
    @Query var fromToModels: [FromToModel]

    @State var saved = false

    var body: some View {
        
        VStack(spacing: 16) {
            
            starButton()
            
            tripsList()
            
        }
        .padding()
        .onAppear {
            if (ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == nil) {
                Task {
                    await viewModel.fetchTrips()
                }
                saved = fromToModels.count >= 0 && fromToModels.contains(FromToModel(fromStopLocation: viewModel.fromStopLocation, toStopLocation: viewModel.toStopLocation))
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

    private func starButton() -> some View {
        Button {
            let fromToModel = FromToModel(fromStopLocation: viewModel.fromStopLocation,
                                          toStopLocation: viewModel.toStopLocation)
            if !saved {
                modelContext.insert(fromToModel)
            } else {
                if let fromToModelToDelete = fromToModels.first(where: {$0.fromStopLocation == viewModel.fromStopLocation && $0.toStopLocation == viewModel.toStopLocation}) {
                    modelContext.delete(fromToModelToDelete)
                }
            }
            
            do {
                try modelContext.save()
            } catch {
                print(error.localizedDescription)
            }
            saved = fromToModels.count >= 0 && fromToModels.contains(fromToModel)
            
        } label: {
            VStack {
                if saved {
                    Image(systemName: "star.fill")
                } else {
                    Image(systemName: "star")
                }
            }
        }
        .padding(.top)
    }
    
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
