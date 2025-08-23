//
//  DetailRemoteDataSourceImpl.swift
//  MobileTask
//
//  Created by Adji Firmansyah on 23/08/25.
//

import Foundation
import RxSwift

class DetailRemoteDataSourceImpl: RemoteDataSource {
    typealias Request = String
    typealias Response = AbilitiesResponse
    
    let httpClient: HttpClient
    
    init(httpClient: HttpClient) {
        self.httpClient = httpClient
    }
    
    func execute(request: String?) -> Observable<AbilitiesResponse> {
        guard let request else {
            return Observable.error(NSError(domain: "", code: 0, userInfo: nil))
        }
        
        print("RQUEST URL ", request)
        return httpClient.load(urlString: request, method: "GET", params: nil)
            .flatMap { data -> Observable<AbilitiesResponse> in
                let decoder = JSONDecoder()
                
                do {
                    print("DECODE")
                    let response = try decoder.decode(AbilitiesResponse.self, from: data)
                    print("DECODE SUCCESS")
                    return Observable.just(response)
                } catch {
                    print("ERROR DECODE")
                    return Observable<AbilitiesResponse>.error(error)
                }
            }
    }
}
