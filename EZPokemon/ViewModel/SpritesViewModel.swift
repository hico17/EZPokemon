//
//  SpriteViewModel.swift
//  EZPokemon
//
//  Created by Luca Celiento on 01/11/2020.
//

import Foundation
import RxSwift

struct SpritesViewModel {
    
    var images = BehaviorSubject<[UIImage]>(value: [])
    
    init(sprites: PokemonSprites, pokemonSpriteService: PokemonSpriteProtocol) {
        self.sprites = sprites
        self.pokemonSpriteService = pokemonSpriteService
        fetchData()
    }
    
    // MARK: - Private
    
    private let sprites: PokemonSprites
    private let pokemonSpriteService: PokemonSpriteProtocol
    private let disposeBag = DisposeBag()
    
    private func fetchData() {
        [sprites.front_default, sprites.back_default, sprites.front_female, sprites.back_female, sprites.front_shiny, sprites.back_shiny, sprites.front_shiny_female, sprites.back_shiny_female].compactMap{$0}.forEach{
            pokemonSpriteService.getPokemonImage(url: $0).subscribe(onNext: { downloadedImage in
                var downloadedImages = (try? images.value()) ?? []
                downloadedImages.append(downloadedImage)
                self.images.onNext(downloadedImages)
            }).disposed(by: disposeBag)
        }
    }
}
