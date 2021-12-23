//
//  StateListAppItem.swift
//  StateListApp
//
//  Created by Michelle Poon on 11/22/20.
//

import UIKit

class StateListAppItem: NSObject {

    var name = ""
    var flag = ""
    var seal = ""
    var abbreviation = ""
    var area = 0.0
    var capitol = ""
    var largestCity = "" 
    var population = 0_000_000_000
    
    
    init(_ iName: String, _ iImage: String, _ iSeal: String, _ iAbbreviation: String,  _ iArea: Double, _ iCapitol: String, _ iLargestCity: String, _ iPopulation: Int){
        name = iName
        flag = iImage
        seal = iSeal
        abbreviation = iAbbreviation
        area = iArea
        capitol = iCapitol
        largestCity = iLargestCity
        population = iPopulation
    }
}
