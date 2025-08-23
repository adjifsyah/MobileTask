//
//  UserEntity.swift
//  MobileTask
//
//  Created by Adji Firmansyah on 22/08/25.
//


import RealmSwift

class UserEntity: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String
    @Persisted var username: String
    @Persisted var password: String
}
