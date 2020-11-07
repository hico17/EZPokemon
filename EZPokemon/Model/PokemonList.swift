//
//  GetPokemonList.swift
//  EZPokemon
//
//  Created by Luca Celiento on 31/10/2020.
//

import Foundation

struct PokemonList: Decodable {
    let count: Int
    let results: [PokemonListItem]
}
