//
//  ApexPredator.swift
//  JPApexPredators17
//
//  Created by Rooshi Patidar on 6/18/24.
//

import Foundation
import SwiftUI
import MapKit

struct ApexPredator: Decodable, Identifiable {
    let id: Int
    let name: String
    let type: PredatorType
    let latitude: Double
    let longitude: Double
    let movies: [String]
    let movieScenes: [MovieScene]
    let link: String
    
    var image: String {
        return name.lowercased().replacingOccurrences(of: " ", with: "")
    }
    
    var location: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    struct MovieScene: Decodable, Identifiable {
        let id: Int
        let movie: String
        let sceneDescription: String
    }
    
    enum PredatorType: String, Decodable, CaseIterable, Identifiable {
        //with the "String" above, we set the rawvalue type to be a String which still matches the JSON
        case all, land, air, sea
        
        var id: PredatorType {
            self
        }
        
        var backgroundColor: Color {
            switch self {
            case .land:
                    .brown
            case .air:
                    .teal
            case .sea:
                    .blue
            case .all:
                    .white
            }
        }
        
        var filterIcon: String {
            switch self {
            case .land:
                "leaf.fill"
            case .air:
                "wind"
            case .sea:
                "drop.fill"
            case .all:
                "square.stack.3d.up.fill"
            }
        }
    }
}
