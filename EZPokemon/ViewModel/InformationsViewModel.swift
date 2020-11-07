//
//  InformationsViewModel.swift
//  EZPokemon
//
//  Created by Luca Celiento on 01/11/2020.
//

import Foundation
import RxSwift

struct InformationsViewModel {
    
    lazy var weight = Observable<String>.just(String(format: "%.2f", pokemonDetail.weight * 0.1) + " kg")
    lazy var height = Observable<String>.just(String(format: "%.2f", pokemonDetail.height * 0.1) + " m")
    lazy var order = Observable<String>.just(String(pokemonDetail.order))
    
    init(pokemonDetail: PokemonDetail) {
        self.pokemonDetail = pokemonDetail
    }
    
    // MARK: - Private
    
    private let disposeBag = DisposeBag()
    private let pokemonDetail: PokemonDetail
}
