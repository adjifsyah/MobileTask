//
//  PokeResponse.swift
//  MobileTask
//
//  Created by Adji Firmansyah on 21/08/25.
//

import Foundation

struct ListPokemonResponse: Codable {
    let next: String
    let results: [PokemonResponse]
}

struct PokemonResponse: Codable {
    let name: String
    let url: String
}
