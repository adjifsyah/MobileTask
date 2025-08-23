//
//  DetailLocaleDataSourceImpl.swift
//  MobileTask
//
//  Created by Adji Firmansyah on 23/08/25.
//

import Foundation
import RxSwift
import RealmSwift

class DetailLocaleDataSourceImpl: LocaleDataSource {
    typealias Request = String
    typealias Response = DetailPokemonEntity
    
    private let realm: Realm
    init(realm: Realm) {
        self.realm = realm
    }
    
    func get(request: String) -> Observable<DetailPokemonEntity> {
        fatalError("Not implemented")
    }
    
    func list(request: String?) -> Observable<[DetailPokemonEntity]> {
        return Observable.create { observer in
            let results = self.realm.objects(DetailPokemonEntity.self)
            
            observer.onNext(Array(results))
            observer.onCompleted()
            
            return Disposables.create()
            
            }
        }
        
        func add(entity: DetailPokemonEntity) -> Observable<Bool> {
            return Observable.create { observer in
                do {
                    try self.realm.write {
                        self.realm.add(entity, update: .modified)
                    }
                    
                    observer.onNext(true)
                    observer.onCompleted()
                } catch let error {
                    observer.onError(error)
                }
                return Disposables.create()
            }
        }
    
    func update(id: Int, entity: DetailPokemonEntity) -> Observable<Bool> {
        fatalError("Not implemented")
    }
    
    func delete(id: Int) -> Observable<Bool> {
        fatalError("Not implemented")
    }
    
    
}
