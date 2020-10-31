//
//  GetPokemonDetail.swift
//  EZPokemon
//
//  Created by Luca Celiento on 31/10/2020.
//

import Foundation

struct GetPokemonDetail: Decodable {
    let sprites: PokemonSprites
}

struct PokemonSprites: Decodable {
    let back_female: String?
    let back_shiny_female: String?
    let back_default: String?
    let front_female: String?
    let front_shiny_female: String?
    let back_shiny: String?
    let front_default: String
    let front_shiny: String?
}
