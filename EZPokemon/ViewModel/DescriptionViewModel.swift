//
//  DescriptionViewModel.swift
//  EZPokemon
//
//  Created by Luca Celiento on 03/11/2020.
//

import Foundation
import RxSwift

class DescriptionViewModel {
    
    lazy var gameDescription = Observable<String?>.just(pokemonSpeciesDetail.flavor_text_entries.first(where: {$0.language.name == "en"})?.version.name ?? "")
    lazy var flavorText = Observable<String?>.just(pokemonSpeciesDetail.flavor_text_entries.first(where: {$0.language.name == "en"})?.flavor_text ?? "")
    
    init(pokemonSpeciesDetail: PokemonSpeciesDetail) {
        self.pokemonSpeciesDetail = pokemonSpeciesDetail
        fetchData()
        
    }
    
    // MARK: - Private
    
    private let pokemonSpeciesDetail: PokemonSpeciesDetail
    private let disposeBag = DisposeBag()
    
    private func fetchData() {
        if let game = pokemonSpeciesDetail.flavor_text_entries.first(where: {$0.language.name == "en"})?.version.name {
            gameDescription = Observable.just("[Pokémon \(game)]")
        }
        if let description = pokemonSpeciesDetail.flavor_text_entries.first(where: {$0.language.name == "en"})?.flavor_text {
            flavorText = Observable.just(description.components(separatedBy: .whitespacesAndNewlines).joined(separator: " "))
        }
    }
}
