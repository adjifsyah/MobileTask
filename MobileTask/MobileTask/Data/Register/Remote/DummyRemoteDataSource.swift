//
//  DummyRemoteDataSource.swift
//  MobileTask
//
//  Created by Adji Firmansyah on 22/08/25.
//

import Foundation
import RxSwift

final class DummyRemoteDataSource: RemoteDataSource {
    typealias Request = UserModel
    typealias Response = UserEntity
    
    func execute(request: UserModel?) -> Observable<UserEntity> {
        return Observable.error(AuthError.notImpelemented)
    }
}
