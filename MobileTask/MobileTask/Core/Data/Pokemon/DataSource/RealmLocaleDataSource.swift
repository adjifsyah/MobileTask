//
//  RealmClient.swift
//  MobileTask
//
//  Created by Adji Firmansyah on 22/08/25.
//

import Foundation
import RealmSwift
import RxSwift

class RealmLocaleDataSource: LocaleDataSource {
    typealias Request = PokemonModel
    typealias Response = PokemonEntity
    
    private let realm: Realm
    
    init(realm: Realm) {
        self.realm = realm
    }
    
    func get(request: PokemonModel) -> Observable<PokemonEntity> {
        return Observable.create { observer in
            let entity = self.realm.object(ofType: PokemonEntity.self, forPrimaryKey: request.name)
            
            guard let entity else {
                observer.onError(NSError(
                    domain: "RealmLocaleDataSource",
                    code: 404,
                    userInfo: [NSLocalizedDescriptionKey: "Entity with name \(request.name) not found"]
                ))
                return Disposables.create()
            }
            
            observer.onNext(entity)
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
    func list(request: PokemonModel?) -> Observable<[PokemonEntity]> {
        return Observable.create { observer in
            let results = self.realm.objects(PokemonEntity.self)
            observer.onNext(Array(results))
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
    func add(entity: PokemonEntity) -> Observable<Bool> {
        return Observable.create { observer in
            do {
                try self.realm.write {
                    self.realm.add(entity, update: .modified)
                }
                
                observer.onNext(true)
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            
            return Disposables.create()
        }
    }
    
    func update(id: Int, entity: PokemonEntity) -> Observable<Bool> {
        return add(entity: entity)
    }
    
    func delete(id: Int) -> Observable<Bool> {
        return Observable.create { observer in
            do {
                guard let entity = self.realm.object(ofType: PokemonEntity.self, forPrimaryKey: id) else {
                    observer.onError(NSError(
                        domain: "RealmLocaleDataSource",
                        code: 404,
                        userInfo: [NSLocalizedDescriptionKey: "Entity with ID \(id) not found"]
                    ))
                    return Disposables.create()
                }
                
                try self.realm.write {
                    self.realm.delete(entity)
                }
                
                observer.onNext(true)
                observer.onCompleted()
                
            } catch {
                observer.onError(error)
            }
            
            return Disposables.create()
        }
    }
}
