//
//  DummyLoginRemoteDataSource.swift
//  MobileTask
//
//  Created by Adji Firmansyah on 23/08/25.
//

import Foundation
import RxSwift

class DummyLoginRemoteDataSource: RemoteDataSource {
    typealias Request = UserModel
    typealias Response = UserModel

    func execute(request: UserModel?) -> Observable<UserModel> {
        return Observable.error(AuthError.notImpelemented)
    }
}
