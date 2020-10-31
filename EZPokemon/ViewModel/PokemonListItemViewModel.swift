//
//  PokemonListItemViewModel.swift
//  EZPokemon
//
//  Created by Luca Celiento on 30/10/2020.
//

import Foundation
import RxSwift

struct PokemonListItemViewModel {
    
    lazy var name = Observable<String>.just(pokemonListItem.name)
    var image = PublishSubject<UIImage>()
    
    init(pokemonListItem: GetPokemonListItem) {
        self.pokemonListItem = pokemonListItem
    }
    
    func fetchData() {
        
    }
    
    // MARK: Private
    
    private let pokemonListItem: GetPokemonListItem
}
