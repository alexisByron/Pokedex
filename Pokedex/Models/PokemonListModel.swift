//
//  PokemonListModel.swift
//  Pokedex
//
//  Created by Alexis Moya on 22-08-22.
//

import Foundation

struct pokemonListStruct: Hashable, Decodable{
    var count: Int
    var next: String?
    var previous: String?
    var results: Array<pokemonResults>
}

struct pokemonResults: Hashable, Decodable{
    var name: String
    var url: String
}
