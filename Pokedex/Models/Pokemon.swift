//
//  Pokemon.swift
//  Pokedex
//
//  Created by Alexis Moya on 22-08-22.
//

import Foundation

struct Pokemon:Decodable{
    var abilities: Array<abilities>
    var base_experience: Int
    var forms: Array<forms>
    var game_indices: Array<game_indices>
    var height: Int
    var held_items: Array<held_items>
    var id: Int
    var is_default: Bool
    var location_area_encounters:String
    var moves: Array<moves>
    var name: String
    var order:Int
    //var past_types: Array<Any>
    var species: species
    var sprites: sprites
    var stats: Array<stats>
    var types: Array<types>
    var weight: Int
}

struct abilities:Decodable, Hashable{
    var ability: ability
    var is_hidden: Bool
    var slot: Int
}

struct ability:Decodable, Hashable{
    var name: String
    var url: String
}

struct forms:Decodable{
    var name: String
    var url: String
}

struct game_indices:Decodable{
    var game_index: Int
    var version: version
}

struct version:Decodable{
    var name: String
    var url: String
}

struct held_items:Decodable{
    var item: item
    var version_details: Array<version_detail>
}

struct item:Decodable{
    var name: String
    var url: String
}

struct version_detail:Decodable{
    var rarity: Int
    var version: version
}

struct moves:Decodable, Hashable{
    var move: move
    var version_group_details: Array<version_group_details>
}

struct move:Decodable, Hashable{
    var name: String
    var url: String
}

struct version_group_details:Decodable, Hashable{
    var level_learned_at: Int
    var move_learn_method:move_learn_method
    var version_group: version_group
}

struct move_learn_method:Decodable,Hashable{
    var name: String
    var url: String
}

struct version_group:Decodable, Hashable{
    var name: String
    var url: String
}

struct species:Decodable{
    var name: String
    var url: String
}

struct sprites:Decodable{
    var back_default: String?
    var back_female: String?
    var back_shiny: String?
    var back_shiny_female: String?
    var front_default: String?
    var front_female: String?
    var front_shiny: String?
    var front_shiny_female: String?
    //var other: Any
    //var versions: Any
}

struct stats:Decodable, Hashable{
    var base_stat: Int
    var effort: Int
    var stat: stat
}

struct stat:Decodable, Hashable{
    var name: String
    var url: String
}

struct types:Decodable{
    var slot: Int
    var type: type
}

struct type:Decodable{
    var name: String
    var url: String
}
