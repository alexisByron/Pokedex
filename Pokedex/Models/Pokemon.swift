//
//  Pokemon.swift
//  Pokedex
//
//  Created by Alexis Moya on 22-08-22.
//

import Foundation

struct Pokemon:Decodable, Encodable, Hashable{
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
    var species: species
    var sprites: sprites
    var stats: Array<stats>
    var types: Array<types>
    var weight: Int
}

struct abilities:Decodable,Encodable, Hashable{
    var ability: ability
    var is_hidden: Bool
    var slot: Int
}

struct ability:Decodable,Encodable, Hashable{
    var name: String
    var url: String
}

struct forms:Decodable,Encodable, Hashable{
    var name: String
    var url: String
}

struct game_indices:Decodable,Encodable, Hashable{
    var game_index: Int
    var version: version
}

struct version:Decodable,Encodable, Hashable{
    var name: String
    var url: String
}

struct held_items:Decodable,Encodable, Hashable{
    var item: item
    var version_details: Array<version_detail>
}

struct item:Decodable,Encodable, Hashable{
    var name: String
    var url: String
}

struct version_detail:Decodable,Encodable, Hashable{
    var rarity: Int
    var version: version
}

struct moves:Decodable,Encodable, Hashable{
    var move: move
    var version_group_details: Array<version_group_details>
}

struct move:Decodable,Encodable, Hashable{
    var name: String
    var url: String
}

struct version_group_details:Decodable,Encodable, Hashable{
    var level_learned_at: Int
    var move_learn_method:move_learn_method
    var version_group: version_group
}

struct move_learn_method:Decodable,Encodable,Hashable{
    var name: String
    var url: String
}

struct version_group:Decodable,Encodable, Hashable{
    var name: String
    var url: String
}

struct species:Decodable,Encodable, Hashable{
    var name: String
    var url: String
}

struct sprites:Decodable,Encodable, Hashable{
    var back_default: String?
    var back_female: String?
    var back_shiny: String?
    var back_shiny_female: String?
    var front_default: String?
    var front_female: String?
    var front_shiny: String?
    var front_shiny_female: String?
    var other: other
}

struct other:Decodable,Encodable, Hashable{
    var dream_world: dreamWorld
}

struct dreamWorld:Decodable,Encodable, Hashable{
    var front_default: String?
    var front_female: String?
}

struct stats:Decodable,Encodable, Hashable{
    var base_stat: Int
    var effort: Int
    var stat: stat
}

struct stat:Decodable,Encodable, Hashable{
    var name: String
    var url: String
}

struct types:Decodable,Encodable, Hashable{
    var slot: Int
    var type: type
}

struct type:Decodable,Encodable, Hashable{
    var name: String
    var url: String
}
