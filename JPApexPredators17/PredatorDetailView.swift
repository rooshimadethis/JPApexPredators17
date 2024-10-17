//
//  PredatorDetailView.swift
//  JPApexPredators17
//
//  Created by Rooshi Patidar on 7/21/24.
//

import SwiftUI
import MapKit

struct PredatorDetailView: View {
    let predator: ApexPredator
    
    @State var position: MapCameraPosition
    
    var body: some View {
        
        GeometryReader { geo in
            
            ScrollView {
                ZStack(alignment: .bottomTrailing) {
                    // background image
                    Image(predator.type.rawValue)
                        .resizable()
                        .scaledToFit()
                        .overlay {
                        LinearGradient(
                            stops: [
                                Gradient.Stop(color: .clear, location: 0.8),
                                Gradient.Stop(color: .black, location: 1)
                            ],
                            startPoint: .top, endPoint: .bottom)
                        
                        }
                    
                    // dinosaur picture
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width/1.5, height: geo.size.height/3)
                        .scaleEffect(x: -1)
                        .shadow(color: .black, radius: 7)
                        .offset(y: 20)
                }
                
                VStack(alignment: .leading) {
                    
                    // Dino Name
                    Text(predator.name)
                        .font(.largeTitle)
                    
                    // Current Location
                    NavigationLink {
                        Image(predator.image)
                    } label: {
                        Map(position: $position) {
                            Annotation(predator.name, coordinate: predator.location, content: { Image(systemName: "mappin.and.ellipse")
                                    .font(.largeTitle)
                                    .imageScale(.large)
                                    .symbolEffect(.pulse)
                            })
                            .annotationTitles(.hidden)
                        }
                        .frame(height: 125)
                        .overlay(alignment: .trailing) {
                            Image(systemName: "greaterthan")
                                .imageScale(.large)
                                .font(.title3)
                                .padding(.trailing, 5)
                        }
                        .overlay(alignment: .topLeading) {
                            Text("Current Location")
                                .padding([.leading, .bottom], 5)
                                .padding(.trailing, 8)
                                .background(.black.opacity(0.33))
                                .clipShape(.rect(bottomTrailingRadius: 5))
                        }
                        .clipShape(.rect(cornerRadius: 10))

                    }
                    
                    
                    //Appears in
                    Text("Appears In: ")
                        .font(.title3)
                    
                    ForEach(predator.movies, id: \.self) { movie in
                        Text("•" + movie)
                            .font(.subheadline)
                    }
                    
                    // Movie Moments
                    Text("Movie Moments")
                        .font(.title)
                        .padding(.top, 15)
                    
                    ForEach(predator.movieScenes) { scene in
                        Text(scene.movie)
                            .font(.title2)
                            .padding(.vertical, 1)
                        
                        Text(scene.sceneDescription)
                            .padding(.bottom, 15)
                    }
                    
                    // Link to webpage
                    Text("Read More:")
                        .font(.caption)
                    
                    Link(predator.link, destination: URL(string: predator.link)!)
                        .font(.caption)
                        .foregroundStyle(.blue)
                        .padding(.bottom)
                    
                    
                }
                .padding()
                .frame(width: geo.size.width, alignment: .leading)
                
            }
            .ignoresSafeArea()
        }
        .toolbarBackground(.automatic)
    }
}

#Preview {
    NavigationStack {
        PredatorDetailView(predator: Predators().allApexPredators[2], position: .camera(MapCamera(centerCoordinate: Predators().allApexPredators[2].location, distance: 30000)))
            .preferredColorScheme(.dark)
    }
}
