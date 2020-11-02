//
//  AbilityViewM.swift
//  EZPokemon
//
//  Created by Luca Celiento on 01/11/2020.
//

import Foundation
import RxSwift

struct AbilitiesViewModel {

    lazy var abilities = Observable<[PokemonAbility]>.just(pokemonAbilities)
    
    init(pokemonAbilities: [PokemonAbility]) {
        self.pokemonAbilities = pokemonAbilities
    }
    
    // MARK: - Private
    
    private let pokemonAbilities: [PokemonAbility]
    
}
