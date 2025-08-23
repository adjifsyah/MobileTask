//
//  DetailPokemonEntity.swift
//  MobileTask
//
//  Created by Adji Firmansyah on 23/08/25.
//

import Foundation
import RealmSwift

class DetailPokemonEntity: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: Int = 0
    @Persisted var name: String = ""
    @Persisted var abilityName: String = ""
    @Persisted var url: String = ""
}
