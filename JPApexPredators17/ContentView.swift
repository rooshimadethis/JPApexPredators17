//
//  ContentView.swift
//  JPApexPredators17
//
//  Created by Rooshi Patidar on 6/18/24.
//

import SwiftUI
import MapKit

struct ContentView: View {
    let predators = Predators()
    
    @State var searchText = ""
    
    @State var sortAlphabetical = false
    
    @State var filterSelection = ApexPredator.PredatorType.all
    
    var filteredDinos: [ApexPredator] {
        predators.filterPredators(by: filterSelection)
        predators.sort(by: sortAlphabetical)

        return predators.search(for: searchText)
    }
    
    var body: some View {
        
        NavigationStack {
            List(filteredDinos) { predator in
                
                NavigationLink {
                    PredatorDetailView(predator: predator, position: .camera(MapCamera(centerCoordinate: predator.location, distance: 30000)))
                } label: {
                    
                    HStack {
                        //dinosaur image
                        Image(predator.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .shadow(color: .white, radius: 1, x: 0.0, y: 0.0)

                        
                        VStack(alignment: .leading) {
                            //Name
                            Text(predator.name)
                                .fontWeight(.bold)
                            //Type
                            Text(predator.type.rawValue.capitalized)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.horizontal, 13)
                                .padding(.vertical, 5)
                                .background(predator.type.backgroundColor)
                                .clipShape(.capsule)
                        }
                    }
                }
            }
            .navigationTitle("Apex Predators")
            .searchable(text: $searchText) //this doesn't work by itself because we're still making an HStack for each predator.apexPredators
            .autocorrectionDisabled()
            .animation(.default, value: searchText)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        withAnimation {
                            sortAlphabetical.toggle()
                        }
                    } label: {
                        Image(systemName: sortAlphabetical ? "film" : "textformat")
                            .symbolEffect(.bounce, value: sortAlphabetical)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Picker("Filter", selection: $filterSelection.animation()) {
                            ForEach(ApexPredator.PredatorType.allCases) { type in
                                Label(type.rawValue.capitalized, systemImage: type.filterIcon)
                            }
                        }
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
