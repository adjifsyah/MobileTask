//
//  DetailMapperImpl.swift
//  MobileTask
//
//  Created by Adji Firmansyah on 23/08/25.
//

import Foundation

struct DetailMapperImpl: Mapper {
    typealias Response = AbilitiesResponse
    typealias Entity = [DetailPokemonEntity]
    typealias Domain = DetailPokemonModel
    
    func transformEntitiesToDomain(entities: [DetailPokemonEntity]) -> DetailPokemonModel {
        guard entities.isEmpty else { return DetailPokemonModel(id: 0, name: "", ability: []) }
        
        let abilities = entities.map { entity in
            AbilityModel(name: entity.abilityName, url: entity.url)
        }
        
        guard let id = entities.first?.id, let name = entities.first?.name else {
            return DetailPokemonModel(id: 0, name: "", ability: [])
        }
        return DetailPokemonModel(id: id, name: name, ability: abilities)
    }
    
    func transformResponseToDomain(response: AbilitiesResponse) -> DetailPokemonModel {
        let abilities = response.abilities.map { response in
            AbilityModel(name: response.ability.name, url: response.ability.url)
        }
        
        return DetailPokemonModel(id: response.id, name: response.name, ability: abilities)
    }
    
    func transformDomainToEntities(domain: DetailPokemonModel) -> [DetailPokemonEntity] {
        domain.ability.map { ability in
            let entity = DetailPokemonEntity()
            entity.id = domain.id
            entity.name = domain.name
            entity.abilityName = ability.name
            entity.url = ability.url
            
            return entity
        }
    }
}
