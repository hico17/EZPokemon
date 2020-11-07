//
//  PokemonDetail.swift
//  EZPokemon
//
//  Created by Luca Celiento on 31/10/2020.
//

import Foundation

struct PokemonDetail: Decodable {
    let name: String
    let order: Int
    let height: Double
    let weight: Double
    let abilities: [PokemonAbility]
    let types: [PokemonType]
    let sprites: PokemonSprites
    let game_indices: [GameIndex]
    let moves: [PokemonMove]
    let stats: [PokemonStat]
}

struct PokemonAbility: Decodable {
    let is_hidden: Bool
    let ability: Ability
    
    struct Ability: Decodable {
        let name: String
        let url: String
    }
}

struct PokemonSprites: Decodable {
    let back_female: String?
    let back_shiny_female: String?
    let back_default: String?
    let front_female: String?
    let front_shiny_female: String?
    let back_shiny: String?
    let front_default: String?
    let front_shiny: String?
    
    var isEmpty: Bool {
        return back_female == nil && back_shiny_female == nil && back_default == nil && front_female == nil && front_shiny_female == nil && back_shiny == nil && front_default == nil && front_shiny == nil
    }
}

struct GameIndex: Decodable {
    let game_index: Int
    let version: Version
    
    struct Version: Decodable {
        let name: String
        let url: String
    }
}

struct PokemonMove: Decodable {
    let move: Move
    
    struct Move: Decodable {
        let name: String
        let url: String
    }
}

struct PokemonStat: Decodable {
    let base_stat: Int
    let effort: Int
    let stat: Stat
    
    struct Stat: Decodable {
        let name: String
        let url: String
    }
}

struct PokemonType: Decodable {
    let slot: Int
    let type: TypeDetail
    
    struct TypeDetail: Decodable {
        let name: String
        let url: String
    }
}
