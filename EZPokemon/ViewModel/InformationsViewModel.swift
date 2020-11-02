//
//  InformationsViewModel.swift
//  EZPokemon
//
//  Created by Luca Celiento on 01/11/2020.
//

import Foundation
import RxSwift

struct InformationsViewModel {
    
    var image = BehaviorSubject<UIImage>(value: UIImage.Named.missingno)
    lazy var weight = Observable<String>.just(String(pokemonDetail.weight))
    lazy var height = Observable<String>.just(String(pokemonDetail.height))
    lazy var order = Observable<String>.just(String(pokemonDetail.order))
    
    init(pokemonDetail: PokemonDetail, pokemonSpriteService: PokemonSpriteProtocol) {
        self.pokemonDetail = pokemonDetail
        self.pokemonSpriteService = pokemonSpriteService
        fetchData()
    }
    
    // MARK: - Private
    
    private let disposeBag = DisposeBag()
    private let pokemonDetail: PokemonDetail
    private let pokemonSpriteService: PokemonSpriteProtocol
    
    private func fetchData() {
        pokemonSpriteService.getPokemonImage(url: pokemonDetail.sprites.front_default).subscribe(onNext: { image in
            self.image.onNext(image)
        }).disposed(by: disposeBag)
    }
}
