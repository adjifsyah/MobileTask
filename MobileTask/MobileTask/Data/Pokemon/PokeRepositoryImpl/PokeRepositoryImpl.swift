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
        guard let requestURL = request, let urlComponents = URLComponents(string: requestURL) else {
            return fallbackFromDB(offset: 0, limit: 20)
        }
        
        let offset = urlComponents
            .queryItems?
            .first(where: { $0.name == "offset" })?
            .value.flatMap { Int($0) } ?? 0
        
        let limit = urlComponents
            .queryItems?
            .first(where: { $0.name == "limit" })?
            .value.flatMap { Int($0) } ?? 20

        return self.remote.execute(request: request)
            .flatMap { response -> Observable<ListPokemonModel> in
                let domain = self.mapper.transformResponseToDomain(response: response)
                let entities = self.mapper.transformDomainToEntities(domain: domain)
                
                return Observable.from(entities)
                    .flatMap { entity in self.locale.add(entity: entity) }
                    .toArray()
                    .asObservable()
                    .map { _ in domain }
            }
            .catch { _ in
                return self.fallbackFromDB(offset: offset, limit: limit)
            }
    }

    private func fallbackFromDB(offset: Int, limit: Int) -> Observable<ListPokemonModel> {
        return self.locale.list(request: nil)
            .map { allEntities in
                let pagedEntities: [PokemonEntity]
                
                if offset == 0 {
                    pagedEntities = Array(allEntities)
                } else {
                    pagedEntities = Array(allEntities.dropFirst(offset).prefix(limit))
                }
                
                return self.mapper.transformEntitiesToDomain(entities: pagedEntities)
            }
    }
}
