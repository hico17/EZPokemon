//
//  SpriteViewModel.swift
//  EZPokemon
//
//  Created by Luca Celiento on 02/11/2020.
//

import UIKit
import RxSwift

struct SpriteViewModel {
    
    var image = BehaviorSubject<UIImage>(value: UIImage.Named.missingno)
    
    init(url: String, pokemonSpriteService: PokemonSpriteProtocol) {
        self.url = url
        self.pokemonSpriteService = pokemonSpriteService
        self.fetchData()
    }
    
    // MARK: - Private
    
    private let url: String
    private let pokemonSpriteService: PokemonSpriteProtocol
    private let disposeBag = DisposeBag()
    
    private func fetchData() {
        pokemonSpriteService.getPokemonImage(url: url).subscribe(onNext: { downloadedImage in
            image.onNext(downloadedImage)
        }).disposed(by: disposeBag)
    }
}
