//
//  DetailRepositoryImpl.swift
//  MobileTask
//
//  Created by Adji Firmansyah on 23/08/25.
//

import Foundation
import RxSwift

class DetailRepositoryImpl<
    Remote: RemoteDataSource,
    Local: LocaleDataSource,
    Transformer: Mapper
>: Repository where Remote.Request == String,
                    Remote.Response == AbilitiesResponse,
                    Local.Request == String,
                    Local.Response == DetailPokemonEntity,
                    Transformer.Response == AbilitiesResponse,
                    Transformer.Domain == DetailPokemonModel,
                    Transformer.Entity == [DetailPokemonEntity] {
    typealias Request = String
    typealias Response = DetailPokemonModel
    
    private let remote: Remote
    private let locale: Local
    private let mapper: Transformer
    
    init(remote: Remote, locale: Local, mapper: Transformer) {
        self.remote = remote
        self.locale = locale
        self.mapper = mapper
    }
    
    func execute(request: String?) -> Observable<DetailPokemonModel> {
        remote.execute(request: request)
            .flatMap { response -> Observable<DetailPokemonModel> in
                // Transform response ke domain
                let model = self.mapper.transformResponseToDomain(response: response)
                
                // Transform domain ke entities untuk disimpan
                let entities = self.mapper.transformDomainToEntities(domain: model)
                
                // Simpan semua entity ke database
                let saveObservable = Observable.from(entities)
                    .flatMap { entity in
                        self.locale.add(entity: entity)
                    }
                    .toArray()
                    .asObservable()
                    .map { _ in model }
                
                return saveObservable
            }
            .catch { _ in
                self.locale.list(request: request) // list masih menerima semua, tapi nanti kita filter
                    .flatMap { entity -> Observable<DetailPokemonModel> in
                        // Ambil ID terakhir dari URL
                        Observable.create { observer in
                            guard let url = request,
                                  let idString = url.split(separator: "/").last,
                                  let id = Int(idString) else {
                                observer.onError(NSError(domain: "", code: 0, userInfo: [:]))
                                
                                return Disposables.create()
                            }
                            
                            // Filter hanya entity yang sesuai ID
                            let filteredEntities = entity.filter { entity in
                                entity.id == id
                            }
                            
                            // Transform filtered entity ke domain
                            let domain = self.mapper.transformEntitiesToDomain(entities: filteredEntities)
                            observer.onNext(domain)
                            observer.onCompleted()
                            return Disposables.create()
                        }
                    }
            }
    }

}
