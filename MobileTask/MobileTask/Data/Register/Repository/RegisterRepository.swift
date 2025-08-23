//
//  RegisterRepository.swift
//  MobileTask
//
//  Created by Adji Firmansyah on 22/08/25.
//

import Foundation
import RxSwift

class RegisterRepositoryImpl<
    Remote: RemoteDataSource,
    Local: LocaleDataSource,
    Transformer: Mapper
>: Repository where Remote.Request == UserModel,
                    Remote.Response == UserEntity,
                    Local.Request == UserModel,
                    Local.Response == UserEntity,
                    Transformer.Domain == UserModel,
                    Transformer.Entity == UserEntity
{
    
    typealias Request = UserModel
    typealias Response = Bool
    
    private let mapper: Transformer
    private let remote: Remote
    private let local: Local
    
    init(mapper: Transformer, remote: Remote, local: Local) {
        self.mapper = mapper
        self.remote = remote
        self.local = local
    }
    
    
    func execute(request: UserModel?) -> Observable<Bool> {
        guard let request else {
            return Observable.error(AuthError.unknown)
        }
        
        let user = self.mapper.transformDomainToEntities(domain: request)

        return self.local.add(entity: user)
    }

}
