//
//  PokeMapper.swift
//  MobileTask
//
//  Created by Adji Firmansyah on 21/08/25.
//

import Foundation

struct ListMapperImpl: Mapper {
    typealias Response = ListPokemonResponse
    typealias Entity = [PokemonEntity]
    typealias Domain = ListPokemonModel
    
    func transformEntitiesToDomain(entities: [PokemonEntity]) -> ListPokemonModel {
        let arrModel = entities.map { entity in
            PokemonModel(name: entity.name, url: entity.url)
        }
        
        return ListPokemonModel(next: nil, results: arrModel)
    }
    
    func transformResponseToDomain(response: ListPokemonResponse) -> ListPokemonModel {
        let arrModel = response.results.map { poke in
            PokemonModel(name: poke.name, url: poke.url)
        }
        return ListPokemonModel(next: response.next, results: arrModel)
    }
    
    func transformDomainToEntities(domain: ListPokemonModel) -> [PokemonEntity] {
        domain.results.map { poke in
            let entity = PokemonEntity()
            entity.name = poke.name
            entity.url = poke.url
            
            return entity
        }
    }
    
}
