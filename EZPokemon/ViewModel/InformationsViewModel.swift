//
//  InformationsViewModel.swift
//  EZPokemon
//
//  Created by Luca Celiento on 01/11/2020.
//

import Foundation
import RxSwift

struct InformationsViewModel {
    
    lazy var weight = Observable<String>.just(String(pokemonDetail.weight))
    lazy var height = Observable<String>.just(String(pokemonDetail.height))
    lazy var order = Observable<String>.just(String(pokemonDetail.order))
    
    init(pokemonDetail: PokemonDetail) {
        self.pokemonDetail = pokemonDetail
    }
    
    // MARK: - Private
    
    private let disposeBag = DisposeBag()
    private let pokemonDetail: PokemonDetail
}
