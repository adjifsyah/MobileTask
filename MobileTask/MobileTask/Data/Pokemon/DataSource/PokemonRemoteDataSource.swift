//
//  PokemonDataSource.swift
//  MobileTask
//
//  Created by Adji Firmansyah on 22/08/25.
//

import Foundation
import RxSwift

class PokemonRemoteDataSource: RemoteDataSource {
    typealias Request = String
    typealias Response = ListPokemonResponse
    
    private let httpClient: HttpClient
    
    init(httpClient: HttpClient) {
        self.httpClient = httpClient
    }
    
    func execute(request: String?) -> Observable<ListPokemonResponse> {
        httpClient.load(urlString: request ?? "", method: "GET", params: nil)
            .flatMap { data -> Observable<ListPokemonResponse> in
                let decoder = JSONDecoder()
                
                do {
                    let response = try decoder.decode(ListPokemonResponse.self, from: data)
                    return Observable.just(response)
                } catch {
                    return Observable<ListPokemonResponse>.error(error)
                }
            }
    }
}
