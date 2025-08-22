//
//  Injection.swift
//  MobileTask
//
//  Created by Adji Firmansyah on 22/08/25.
//

import Foundation
import RealmSwift

class Injection {
    static let shared = Injection()
    private init() { }
    
    let client: HttpClient = AlamofireClient()
    let realm = try! Realm()
    
    func provideListPokemonRepository() -> ListPokeRepositoryImpl<
        PokemonRemoteDataSource,
        RealmLocaleDataSource,
        ListMapperImpl
    > {
        let remote = PokemonRemoteDataSource(httpClient: client)
        let locale = RealmLocaleDataSource(realm: realm)
        let mapper = ListMapperImpl()
        let repository = ListPokeRepositoryImpl(remote: remote, locale: locale, mapper: mapper)
        return repository
    }
}
