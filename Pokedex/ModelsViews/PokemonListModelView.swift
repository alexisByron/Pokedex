//
//  PokemonListModelView.swift
//  Pokedex
//
//  Created by Alexis Moya on 22-08-22.
//

import Foundation

class PokemonListModelView: ObservableObject{
    @Published var pokemonList:pokemonListStruct?
    
    init(){
        getPokemonListFromApi(url: "https://pokeapi.co/api/v2/pokemon/" )
    }
    
    func getPokemonListFromApi(url:String){
        Task {
            let (data, _) = try await URLSession.shared.data(from: URL(string: url)!)
            let decodedResponse = try? JSONDecoder().decode(pokemonListStruct.self, from: data)
            print("data decpded")
            debugPrint(decodedResponse)
            self.pokemonList = decodedResponse
        }
    }
}
