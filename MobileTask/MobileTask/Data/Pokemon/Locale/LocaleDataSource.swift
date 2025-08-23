//
//  LocalDataSource.swift
//  MobileTask
//
//  Created by Adji Firmansyah on 21/08/25.
//

import Foundation
import RxSwift

protocol LocaleDataSource {
    associatedtype Request
    associatedtype Response
    
    func get(request: Request) -> Observable<Response>
    func list(request: Request?) -> Observable<[Response]>
    func add(entity: Response) -> Observable<Bool>
    func update(id: Int, entity: Response) -> Observable<Bool>
    func delete(id: Int) -> Observable<Bool>
}
