//
//  HomeView.swift
//  MobileTask
//
//  Created by Adji Firmansyah on 22/08/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel: HomeViewModel = HomeViewModel()
    
    var body: some View {
        VStack {
            TextFieldView(text: $viewModel.queryPokemon, placeholder: "Pencarian", isSecure: true)
                .frame(height: 32)
                .modifier(FormStyle())
                .padding(.top, 24)
                .padding(.horizontal, 16)
            
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach($viewModel.filterPokemons, id: \.id) { pokemon in
                        NavigationLink {
                            DetailView(nextURL: pokemon.wrappedValue.url)
                        } label: {
                            VStack {
                                Text(pokemon.wrappedValue.name)
                                    .onAppear {
                                        if viewModel.isLast(pokemon) {
                                            viewModel.loadMore()
                                        }
                                    }
                                
                                Divider()
                                    .opacity(!viewModel.isLast(pokemon) ? 1 : 0)
                            }
                        }

                        
                        
                    }
                    
                    MBProgressHUDWrapper(isShowing: $viewModel.isLoading, text: "Loading...")
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 14)
            }
            .refreshable {
                viewModel.loadFirstPage()
            }
            .onAppear(perform: viewModel.loadFirstPage)
        }
        .overlay {
            if viewModel.isMainLoading {
                MBProgressHUDWrapper(isShowing: $viewModel.isLoading, text: "Loading...")
            }
        }
        .background(
//            viewModel.emptyView()
            GeometryReader { proxy in
                Text("Data Kosong")
                    .frame(maxWidth: proxy.size.width, maxHeight: proxy.size.height)
                    .opacity(viewModel.pokemons.isEmpty ? 1 : 0)
                    .background(.clear)
            }
        )
    }
}

#Preview {
    HomeView()
}
