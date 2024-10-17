//
//  Predators.swift
//  JPApexPredators17
//
//  Created by Rooshi Patidar on 6/18/24.
//

import Foundation

class Predators {
    var allApexPredators: [ApexPredator] = []
    var currentApexPredators: [ApexPredator] = []
    
    init() {
        decodeApexPredatorData() 
    }
    
    func decodeApexPredatorData() {
        if let url = Bundle.main.url(forResource: "jpapexpredators", withExtension: ".json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = JSONDecoder.KeyDecodingStrategy.convertFromSnakeCase
                
                allApexPredators = try decoder.decode([ApexPredator].self, from: data)
                currentApexPredators = allApexPredators
            } catch {
                print("Error decoding JSON data: \(error)")
            }
        }
    }
    
    func search(for searchTerm: String) -> [ApexPredator] {
        if searchTerm == "" {
            return currentApexPredators
        } else {
            return currentApexPredators.filter { predator in
                predator.name.localizedCaseInsensitiveContains(searchTerm)
            }
        }
    }
    
    func sort(by alphabetical: Bool) {
        currentApexPredators.sort { predator1, predator2 in
            if alphabetical {
                predator1.name < predator2.name
            } else {
                predator1.id < predator2.id
            }
        }
    }
    
    func filterPredators(by type: ApexPredator.PredatorType) {
        if type == .all {
            currentApexPredators = allApexPredators
        } else {
            currentApexPredators = allApexPredators.filter { predator in
                predator.type == type
            }
        }
    }
}
