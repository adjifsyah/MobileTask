//
//  PokeMapper.swift
//  MobileTask
//
//  Created by Adji Firmansyah on 21/08/25.
//

import Foundation

public protocol Mapper {
    associatedtype Response
    associatedtype Entity
    associatedtype Domain
    
    func transformEntitiesToDomain(entities: Entity) -> Domain
    func transformResponseToDomain(response: Response) -> Domain
    func transformDomainToEntities(domain: Domain) -> Entity
}
