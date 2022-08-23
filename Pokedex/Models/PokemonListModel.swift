//
//  PokemonListModel.swift
//  Pokedex
//
//  Created by Alexis Moya on 22-08-22.
//

import Foundation

struct pokemonListStruct:  Decodable{
    var count: Int
    var next: String?
    var previous: String?
    var results: Array<pokemonResults>
}

struct pokemonResults:  Decodable{
    var name: String
    var url: String
}
