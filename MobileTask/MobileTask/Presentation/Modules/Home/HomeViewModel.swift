//
//  HomeViewModel.swift
//  MobileTask
//
//  Created by Adji Firmansyah on 22/08/25.
//

import Foundation
import RxSwift
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var pokemons: [PokemonModel] = []
    @Published var nextPage: String? = nil
    @Published var isMainLoading: Bool = false {
        didSet {
            isLoading = isMainLoading
        }
    }
    @Published var isLoading: Bool = false
    
    private let repository = Injection.shared.provideListPokemonRepository()
    private var disposeBag = DisposeBag()
    
    func loadFirstPage() {
        self.isMainLoading = true
        self.pokemons = []
        
        nextPage = "https://pokeapi.co/api/v2/pokemon/?offset=0&limit=20"
        repository.execute(request: nextPage)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] domain in
                guard let self else { return }
                isMainLoading = false
                pokemons = domain.results
                nextPage = domain.next
            }, onError: { [weak self] error in
                guard let self else { return }
                isMainLoading = false
            })
            .disposed(by: disposeBag)
    }
    
    func loadMore() {
        guard !isLoading else { return }
        guard let nextPage = nextPage else { return }
        isLoading = true
        repository.execute(request: nextPage)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] domain in
                guard let self else { return }
                pokemons.append(contentsOf: domain.results)
                self.nextPage = domain.next
                isLoading = false
            }, onError: { [weak self] error in
                guard let self else { return }
                isLoading = false
                print("Error: \(error)")
            })
            .disposed(by: disposeBag)
    }
    
    func isLast(_ pokemon: Binding<PokemonModel>) -> Bool {
        guard pokemons.count > 0 else  { return true }
        return pokemons.last?.id == pokemon.wrappedValue.id
    }
    
    @ViewBuilder
    func emptyView() -> some View {
        GeometryReader { [weak self] proxy in
            Text("Data Kosong")
                .frame(maxWidth: proxy.size.width, maxHeight: proxy.size.height)
                .opacity(self!.pokemons.isEmpty ? 1 : 0)
                .background(.clear)
        }
    }
    
}
