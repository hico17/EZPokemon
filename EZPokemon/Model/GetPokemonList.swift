//
//  GetPokemonList.swift
//  EZPokemon
//
//  Created by Luca Celiento on 31/10/2020.
//

import Foundation

struct GetPokemonList: Decodable {
    let count: Int
    let results: [GetPokemonListItem]
}
