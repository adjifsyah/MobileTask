//
//  DataSource.swift
//  MobileTask
//
//  Created by Adji Firmansyah on 21/08/25.
//

import Foundation
import RxSwift

protocol HttpClient {
    func load(urlString: String, method: String, params: [String: String]?) -> Observable<Data>
}
