//
//  RemoteDataSource.swift
//  MobileTask
//
//  Created by Adji Firmansyah on 21/08/25.
//

import Foundation
import RxSwift

protocol RemoteDataSource {
    associatedtype Request
    associatedtype Response
    
    func execute(request: Request?) -> Observable<Response>
}
