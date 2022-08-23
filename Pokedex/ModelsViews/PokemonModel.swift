//
//  Pokemon.swift
//  Pokedex
//
//  Created by Alexis Moya on 22-08-22.
//

import Foundation

struct Error{
    var isShowin: Bool
    var message:String
}

struct RecentSearched:Hashable{
    var name:String
    var imageUrl:String
}

class PokemonModel: ObservableObject{
    @Published var pokemon:Pokemon?
    @Published var error:Error = Error(isShowin: false, message: "")
    @Published var pokemonsSearched:Array<RecentSearched> = [RecentSearched]()
    
    func getPokemon(url:String){
        Task {
            self.error = Error(isShowin: false, message: "")
            let (data, _) = try await URLSession.shared.data(from: URL(string: url)!)
            let decodedResponse = try? JSONDecoder().decode(Pokemon.self, from: data)
            if(decodedResponse != nil){
                //Agrego a busquedas exitosas
                let searchExist = pokemonsSearched.filter { $0.name == decodedResponse?.name ?? url}.count > 0
                if(!searchExist){
                    //Agrego si no esta en la lista
                    let searched = RecentSearched(name: decodedResponse?.name ?? url, imageUrl: decodedResponse?.sprites.front_default ?? decodedResponse?.sprites.front_female ?? "")
                    self.pokemonsSearched.append(searched)
                }
                //cambio valor de lista de pokemones a resultado de api
                self.pokemon = decodedResponse
            }else{
                //cambio valor de error a verdadero y algun mensaje
                self.error = Error(isShowin: true, message: "No se encontro pokemon buscado")
            }
        }
    }

}
