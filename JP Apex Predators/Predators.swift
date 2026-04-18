//
//  Predators.swift
//  JP Apex Predators
//
//  Created by Hadeer Ibrahim on 14/04/2026.
//

import Foundation

class Predators {
    // Property that will store the decoding data
    var allApexPredators : [ApexPredator] = []
    var apexPredators: [ApexPredator] = []
    
    init(){
        decodeApexPredatorData()
    }
    
    func decodeApexPredatorData(){
        if let url = Bundle.main.url(forResource: "jpapexpredators", withExtension: "json"){
            do{
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                //set the decoder strategy
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                allApexPredators = try decoder.decode([ApexPredator].self, from: data)
                apexPredators = allApexPredators
            }catch{
                print("Error happen \(error)")
            }
        }
    }
    
    
    func search(for searchText : String)-> [ApexPredator]{
        if searchText.isEmpty{
            return apexPredators
        }else{
            return apexPredators.filter{predator in
                predator.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    func sort(by alphabetic : Bool){
        apexPredators.sort{ first , second in
            if alphabetic {
                first.name < second.name
            }
            else{
                first.id < second.id
            }
            
        }
    }
    
    func filter(by type : APType){
        if type == .all {
            apexPredators = allApexPredators
        }
        else{
            apexPredators = allApexPredators.filter{predator in
                predator.type == type
            }
        }
        
    }
}
