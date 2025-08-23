//
//  DetailPokemonModel.swift
//  MobileTask
//
//  Created by Adji Firmansyah on 23/08/25.
//

import Foundation

struct DetailPokemonModel {
    let id: Int
    let name: String
    let ability: [AbilityModel]
}

struct AbilityModel {
    let name: String
    let url: String
}
