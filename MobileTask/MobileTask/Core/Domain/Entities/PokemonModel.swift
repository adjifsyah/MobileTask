//
//  PokemonModel.swift
//  MobileTask
//
//  Created by Adji Firmansyah on 21/08/25.
//

import Foundation

struct ListPokemonModel {
    let next: String?
    let results: [PokemonModel]
}

struct PokemonModel {
    let name: String
    let url: String
}
