//
//  LoginMapper.swift
//  MobileTask
//
//  Created by Adji Firmansyah on 23/08/25.
//

import Foundation

struct LoginMapper: Mapper {
    typealias Response = UserModel
    typealias Entity = UserEntity
    typealias Domain = UserModel
    
    func transformEntitiesToDomain(entities: UserEntity) -> UserModel {
        UserModel(name: entities.name, username: entities.username, password: entities.password)
    }
    
    func transformResponseToDomain(response: UserModel) -> UserModel {
        fatalError("Not implemented")
    }
    
    func transformDomainToEntities(domain: UserModel) -> UserEntity {
        fatalError("Not implemented")
    }
}
