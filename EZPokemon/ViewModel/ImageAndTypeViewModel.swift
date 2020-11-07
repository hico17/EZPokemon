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
    var isLoading = BehaviorSubject<Bool>(value: false)
    
    init(url: String?, types: [PokemonType], pokemonSpriteService: PokemonSpriteProtocol) {
        self.url = url
        self.types = .just(types.map{$0.type.name.uppercased()}.joined(separator: " / "))
        self.pokemonSpriteService = pokemonSpriteService
        self.fetchData()
    }
    
    // MARK: - Private
    
    private let url: String?
    private let pokemonSpriteService: PokemonSpriteProtocol
    private let disposeBag = DisposeBag()
    
    private func fetchData() {
        isLoading.onNext(true)
        guard let url = url else {
            isLoading.onNext(false)
            image.onNext(UIImage.Named.missingno)
            return
        }
        pokemonSpriteService.getPokemonImage(url: url).subscribe { event in
            isLoading.onNext(false)
            switch event {
            case .next(let downloadedImage):
                image.onNext(downloadedImage)
            default: break
            }
        }.disposed(by: disposeBag)
    }
}
