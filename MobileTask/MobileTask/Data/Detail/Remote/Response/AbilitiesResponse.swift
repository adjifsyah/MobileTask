//
//  AbilitiesResponse.swift
//  MobileTask
//
//  Created by Adji Firmansyah on 23/08/25.
//

import Foundation

struct AbilitiesResponse: Decodable {
    let abilities: [AbilityElement]
    let id: Int
    let name: String
}

struct AbilityElement: Decodable {
    let ability: AbilityAbility
}

struct AbilityAbility: Decodable {
    let name: String
    let url: String
}
