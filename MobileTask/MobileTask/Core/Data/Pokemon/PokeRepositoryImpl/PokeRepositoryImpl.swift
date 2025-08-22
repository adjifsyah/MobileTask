//
//  PokeRepository.swift
//  MobileTask
//
//  Created by Adji Firmansyah on 21/08/25.
//

import Foundation
import RxSwift

class ListPokeRepositoryImpl<
    Remote: RemoteDataSource,
    Local: LocaleDataSource,
    Transformer: Mapper
>: Repository where Remote.Request == String,
                    Remote.Response == ListPokemonResponse,
                    Local.Request == PokemonModel,
                    Local.Response == PokemonEntity,
                    Transformer.Domain == ListPokemonModel,
                    Transformer.Response == ListPokemonResponse,
                    Transformer.Entity == [PokemonEntity] {
    
    typealias Request = String
    typealias Response = ListPokemonModel
    
    private let remote: Remote
    private let locale: Local
    private let mapper: Transformer
    
    init(remote: Remote, locale: Local, mapper: Transformer) {
        self.locale = locale
        self.remote = remote
        self.mapper = mapper
    }
    
    func execute(request: String?) -> Observable<ListPokemonModel> {
        return self.remote.execute(request: request)
            .flatMap { response -> Observable<ListPokemonModel> in
                let domain = self.mapper.transformResponseToDomain(response: response)
                let entities = self.mapper.transformDomainToEntities(domain: domain)
                
                return self.locale.list(request: nil)
                    .flatMap { existingEntities -> Observable<ListPokemonModel> in
                        let existingIds = Set(existingEntities.map { $0.name })
                        
                        return Observable.from(entities)
                            .flatMap { entity -> Observable<PokemonEntity> in
                                if existingIds.contains(entity.name) {
                                    return Observable.empty()
                                } else {
                                    return self.locale.add(entity: entity)
                                        .flatMap { success -> Observable<PokemonEntity> in
                                            if success {
                                                return Observable.just(entity)
                                            } else {
                                                return Observable.empty()
                                            }
                                        }
                                }
                            }
                            .toArray()
                            .asObservable()
                            .map { _ in domain }
                    }
            }
            .catch { _ in
                return self.locale.list(request: nil)
                    .map { localEntities in
                        self.mapper.transformEntitiesToDomain(entities: localEntities)
                    }
            }
    }
}
