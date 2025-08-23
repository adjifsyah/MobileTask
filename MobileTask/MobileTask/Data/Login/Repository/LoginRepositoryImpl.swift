//
//  LoginRepositoryImpl.swift
//  MobileTask
//
//  Created by Adji Firmansyah on 23/08/25.
//

import Foundation
import RealmSwift
import RxSwift

class LoginRepositoryImpl<
    Local: LocaleDataSource,
    Remote: RemoteDataSource,
    Transformer: Mapper
>: Repository where Remote.Request == UserModel,
                    Remote.Response == UserModel,
                    Local.Request == UserModel,
                    Local.Response == UserEntity,
                    Transformer.Response == UserModel,
                    Transformer.Domain == UserModel,
                    Transformer.Entity == UserEntity
                    
{
    typealias Request = UserModel
    typealias Response = UserModel
    
    private let remote: Remote
    private let locale: Local
    private let mapper: Transformer
    
    init(remote: Remote, locale: Local, mapper: Transformer) {
        self.remote = remote
        self.locale = locale
        self.mapper = mapper
    }
    
    func execute(request: UserModel?) -> RxSwift.Observable<UserModel> {
        guard let request else {
            return Observable.error(AuthError.unknownRequest)
        }
        
        return locale.get(request: request)
            .map { entity in
                self.mapper.transformEntitiesToDomain(entities: entity)
            }
    }
}
