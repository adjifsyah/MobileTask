//
//  PokemonEntity.swift
//  MobileTask
//
//  Created by Adji Firmansyah on 21/08/25.
//

import Foundation
import RealmSwift

public class PokemonEntity: Object {
    @objc dynamic var id: UUID = UUID()
    @objc dynamic var name: String = ""
    @objc dynamic var url: String = ""
    
    public override static func primaryKey() -> String? {
        return "id"
    }
}
