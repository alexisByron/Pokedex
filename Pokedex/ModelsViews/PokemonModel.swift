//
//  Pokemon.swift
//  Pokedex
//
//  Created by Alexis Moya on 22-08-22.
//

import Foundation

class PokemonModel: ObservableObject{
    @Published var pokemon:Pokemon?
    
    func getPokemon(url:String){
        Task {
            let (data, _) = try await URLSession.shared.data(from: URL(string: url)!)
            let decodedResponse = try? JSONDecoder().decode(Pokemon.self, from: data)
            self.pokemon = decodedResponse
        }
    }
}
