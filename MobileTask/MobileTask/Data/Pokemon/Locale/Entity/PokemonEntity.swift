//
//  PokemonEntity.swift
//  MobileTask
//
//  Created by Adji Firmansyah on 21/08/25.
//

import Foundation
import RealmSwift

public class PokemonEntity: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String
    @Persisted var url: String
}
