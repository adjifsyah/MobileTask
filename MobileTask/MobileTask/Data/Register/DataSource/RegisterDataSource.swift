//
//  RegisterDataSource.swift
//  MobileTask
//
//  Created by Adji Firmansyah on 22/08/25.
//

import Foundation
import RealmSwift
import RxSwift

class RegisterDataSource: LocaleDataSource {
    typealias Request = UserModel
    typealias Response = UserEntity
    
    private let realm: Realm
    
    init(realm: Realm) {
        self.realm = realm
    }
    
    func get(request: UserModel) -> Observable<UserEntity> {
        fatalError("Not implemented")
    }
    
    func list(request: UserModel?) -> Observable<[UserEntity]> {
        fatalError("Not implemented")
    }
    
    func add(entity: UserEntity) -> Observable<Bool> {
        return Observable.create { observer in
            do {
                let existingUsername = self.realm.objects(UserEntity.self)
                    .filter("username == %@", entity.username)
                    .first
                
                if existingUsername != nil {
                    observer.onError(AuthError.usernameTaken)
                    return Disposables.create()
                }
                
                try self.realm.write {
                    self.realm.add(entity)
                }
                
                observer.onNext(true)
                observer.onCompleted()
                
            } catch {
                observer.onError(AuthError.unknown)
            }
            
            return Disposables.create()
        }
    }
    
    func update(id: Int, entity: UserEntity) -> Observable<Bool> {
        fatalError("Not implemented")
    }
    
    func delete(id: Int) -> Observable<Bool> {
        fatalError("Not implemented")
    }
}
