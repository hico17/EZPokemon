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
    
    func getPokemonList(limit: Int, offset: Int) -> Observable<[GetPokemonListItem]> {        
        return networkManager.executeRequest(url: "https://pokeapi.co/api/v2/pokemon/?limit=\(limit)&offset=\(offset)" + String(offset), method: "GET", dataType: GetPokemonList.self).map{$0.results}
    }
    
    private let decoder = Utilities.Decoder()
    private let networkManager = Utilities.NetworkManager()
}
