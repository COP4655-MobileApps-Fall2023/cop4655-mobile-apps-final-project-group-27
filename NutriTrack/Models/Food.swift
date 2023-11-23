//
//  Food.swift
//  NutriTrack
//
//  Created by Dante Ricketts on 11/23/23.
//

import Foundation

struct FoodsResponse: Decodable{
    let results: [Food]
}

struct Food: Decodable{
    let name: String
    let calories: String
    
}
