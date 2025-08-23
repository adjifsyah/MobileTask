//
//  Injection.swift
//  MobileTask
//
//  Created by Adji Firmansyah on 22/08/25.
//

import Foundation
import RealmSwift

class Injection {
    private let httpClient: HttpClient = AlamofireClient()
    private let realm = try! Realm()
    static let shared = Injection()
    private init() { }
    
    func provideListPokemonRepository() -> ListPokeRepositoryImpl<
        PokemonRemoteDataSource,
        RealmLocaleDataSource,
        ListMapperImpl
    > {
        let remote = PokemonRemoteDataSource(httpClient: httpClient)
        let locale = RealmLocaleDataSource(realm: realm)
        let mapper = ListMapperImpl()
        let repository = ListPokeRepositoryImpl(remote: remote, locale: locale, mapper: mapper)
        return repository
    }
    
    func provideRegisterRepository() -> RegisterRepositoryImpl<
        DummyRemoteDataSource,
        RegisterDataSource,
        RegisterMapperImpl
    > {
        let remote = DummyRemoteDataSource()
        let local = RegisterDataSource(realm: realm)
        let mapper = RegisterMapperImpl()
        let repository = RegisterRepositoryImpl(mapper: mapper, remote: remote, local: local)
        return repository
    }
    
    func provideLoginRepository() -> LoginRepositoryImpl<
        LoginLocaleDataSourceImpl,
        DummyLoginRemoteDataSource,
        LoginMapper
    > {
        let remote = DummyLoginRemoteDataSource()
        let local = LoginLocaleDataSourceImpl(realm: realm)
        let mapper = LoginMapper()
        let repository = LoginRepositoryImpl(remote: remote, locale: local, mapper: mapper)
        return repository
    }
    
    func provideDetailRepository() -> DetailRepositoryImpl<
        DetailRemoteDataSourceImpl,
        DetailLocaleDataSourceImpl,
        DetailMapperImpl
    > {
        let remote: DetailRemoteDataSourceImpl = .init(httpClient: httpClient)
        let locale: DetailLocaleDataSourceImpl = .init(realm: realm)
        let mapper: DetailMapperImpl = .init()
        let repository = DetailRepositoryImpl(remote: remote, locale: locale, mapper: mapper)
        
        return repository
    }
}
