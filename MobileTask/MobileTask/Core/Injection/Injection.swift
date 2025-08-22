//
//  Injection.swift
//  MobileTask
//
//  Created by Adji Firmansyah on 22/08/25.
//

import Foundation
import RealmSwift

class Injection {
    func proviceRepository() {
        let client: HttpClient = AlamofireClient()
        let realm = try! Realm()
        let remote = PokemonRemoteDataSource(httpClient: client)
        let locale = RealmLocaleDataSource(realm: realm)
        let mapper = ListMapperImpl()
        let repo = ListPokeRepositoryImpl(remote: remote, locale: locale, mapper: mapper)
    }
}
