//
//  LoginLocaleDataSourceImpl.swift
//  MobileTask
//
//  Created by Adji Firmansyah on 23/08/25.
//

import Foundation
import RxSwift
import RealmSwift

class LoginLocaleDataSourceImpl: LocaleDataSource {
    typealias Request = UserModel
    typealias Response = UserEntity
    
    let realm: Realm
    
    init(realm: Realm) {
        self.realm = realm
    }
    
    func get(request: UserModel) -> Observable<UserEntity> {
        return Observable<UserEntity>.create { observer in
            let realm = try! Realm()
            
            if let userByUsername = realm.objects(UserEntity.self)
                .filter("username == %@", request.username)
                .first {
                
                if userByUsername.password == request.password {
                    observer.onNext(userByUsername)
                    observer.onCompleted()
                } else {
                    observer.onError(AuthError.wrongPassword)
                }
                
            } else {
                observer.onError(AuthError.userNotFound)
            }
            
            return Disposables.create()
        }
    }
    
    func list(request: UserModel?) -> Observable<[UserEntity]> {
        fatalError("Not implemented")
    }
    
    func add(entity: UserEntity) -> Observable<Bool> {
        fatalError("Not implemented")
    }
    
    func update(id: Int, entity: UserEntity) -> Observable<Bool> {
        fatalError("Not implemented")
    }
    
    func delete(id: Int) -> Observable<Bool> {
        fatalError("Not implemented")
    }
}
