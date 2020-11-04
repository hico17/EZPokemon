//
//  PokemonSpeciesDetail.swift
//  EZPokemon
//
//  Created by Luca Celiento on 03/11/2020.
//

import Foundation
 
struct PokemonSpeciesDetail: Decodable {
    let color: Color
    let flavor_text_entries: [FlavorTextEntry]
}

struct Color: Decodable {
    let name: String
    let url: String
}

struct FlavorTextEntry: Decodable {
    let flavor_text: String
    let language: Language
    let version: Version
}

struct Language: Decodable {
    let name: String
    let url: String
}

struct Version: Decodable {
    let name: String
    let url: String
}
