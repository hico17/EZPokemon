//
//  SpriteViewModel.swift
//  EZPokemon
//
//  Created by Luca Celiento on 02/11/2020.
//

import UIKit
import RxSwift

struct ImageAndTypeViewModel {
    
    var image = BehaviorSubject<UIImage>(value: UIImage.Named.missingno)
    var types: Observable<String>
    
    init(url: String, types: [PokemonType], pokemonSpriteService: PokemonSpriteProtocol) {
        self.url = url
        self.types = .just(types.map{$0.type.name.uppercased()}.joined(separator: " / "))
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
