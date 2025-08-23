//
//  DetailViewModel.swift
//  MobileTask
//
//  Created by Adji Firmansyah on 23/08/25.
//

import Foundation
import RxSwift

class DetailViewModel: ObservableObject {
    @Published var pokemon: DetailPokemonModel = .init(id: 0, name: "", ability: [])
    @Published var isLoading: Bool = false
    
    private let repository = Injection.shared.provideDetailRepository()
    private let disposeBag = DisposeBag()
    
    @Published var title: String = "No Data"
    
    init(nextUrlStr: String) {
        getDetail(nextUrlStr)
    }
}

extension DetailViewModel  {
    func getDetail(_ urlString: String) {
        isLoading = true
        repository.execute(request: urlString)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] pokemon in
                self?.isLoading = false
                self?.pokemon = pokemon
                let name = pokemon.name
                self?.title = name.isEmpty ? "No Data" : name
            }, onError: { [weak self] error in
                self?.title = "No Data"
                print("Error \(error)")
            })
            .disposed(by: disposeBag)
    }
}
