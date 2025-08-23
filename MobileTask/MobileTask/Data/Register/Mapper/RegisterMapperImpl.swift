//
//  RegisterMapperImpl.swift
//  MobileTask
//
//  Created by Adji Firmansyah on 22/08/25.
//

import Foundation

struct RegisterMapperImpl: Mapper {
    typealias Response = UserModel
    
    typealias Entity = UserEntity
    
    typealias Domain = UserModel
    
    func transformEntitiesToDomain(entities: UserEntity) -> UserModel {
        UserModel(name: entities.name, username: entities.username, password: entities.password)
    }
    
    func transformResponseToDomain(response: UserModel) -> UserModel {
        fatalError("not implemented")
    }
    
    func transformDomainToEntities(domain: UserModel) -> UserEntity {
        let entity = UserEntity()
        entity.name = domain.name
        entity.username = domain.username
        entity.password = domain.password
        return entity
    }
}
