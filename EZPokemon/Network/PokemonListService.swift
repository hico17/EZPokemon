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
    
    func getPokemonList(limit: Int, offset: Int) -> Observable<[PokemonListItem]> {        
        return networkManager.executeRequest(url: "https://pokeapi.co/api/v2/pokemon/?limit=\(limit)&offset=\(offset)", method: "GET", dataType: PokemonList.self).map{$0.results}
    }
    
    private let networkManager = Utilities.NetworkManager()
}
