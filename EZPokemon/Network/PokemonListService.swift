//
//  PokemonListService.swift
//  EZPokemon
//
//  Created by Luca Celiento on 29/10/2020.
//

import Foundation
import RxSwift
import Utilities

class PokemonListService: PokemonListProtocol {
    
    func getPokemonList(offset: Int) -> Observable<[PokemonListItem]> {
        return networkManager.executeRequest(url: "https://pokeapi.co/api/v2/pokemon/offset=" + String(offset), method: "GET")
    }
    
    private let decoder = Utilities.Decoder()
    private let networkManager = Utilities.NetworkManager()
}
