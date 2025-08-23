//
//  DetailView.swift
//  MobileTask
//
//  Created by Adji Firmansyah on 23/08/25.
//

import SwiftUI

struct DetailView: View {
    @StateObject var viewModel: DetailViewModel
    
    init(nextURL: String) {
        self._viewModel = StateObject(wrappedValue: DetailViewModel(nextUrlStr: nextURL))
    }
    
    var body: some View {
        List(viewModel.pokemon.ability, id: \.name) { ability in
            Text(ability.name)
        }
        .navigationTitle(viewModel.title)
    }
}

#Preview {
    DetailView(nextURL: "https://pokeapi.co/api/v2/pokemon/1/")
}
