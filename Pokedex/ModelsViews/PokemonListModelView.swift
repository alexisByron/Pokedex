//
//  PokemonListModelView.swift
//  Pokedex
//
//  Created by Alexis Moya on 22-08-22.
//

import Foundation

class PokemonListModelView: ObservableObject{
    @Published var pokemonList:pokemonListStruct?
    @Published var favoritePokemons:Array<Pokemon> = [Pokemon]()
  
    init(){
        getPokemonListFromApi(url: "https://pokeapi.co/api/v2/pokemon/")
        getPokemonFavoritesFromStorage()
    }
    
    func getPokemonListFromApi(url:String){
        Task {
            let (data, _) = try await URLSession.shared.data(from: URL(string: url)!)
            let decodedResponse = try? JSONDecoder().decode(pokemonListStruct.self, from: data)
            self.pokemonList = decodedResponse
        }
    }
    
    func addPokemonFavorite(pokemon:Pokemon){
        self.favoritePokemons.append(pokemon)
        savePokemonFavorites()
    }
    
    func removePokemonFavorite(pokemon:Pokemon){
        self.favoritePokemons = favoritePokemons.filter{ $0.id != pokemon.id }
        savePokemonFavorites()
    }
    
    func savePokemonFavorites(){
        let encoder = JSONEncoder()
        let encodedUserObject = try? encoder.encode(favoritePokemons)
        UserDefaults.standard.set(encodedUserObject, forKey: "pokemonsFavorite")
    }
    
    func getPokemonFavoritesFromStorage(){
        self.favoritePokemons =  UserDefaults.standard.object(forKey: "pokemonsFavorite") as? Array<Pokemon> ?? [Pokemon]()
    }
}
