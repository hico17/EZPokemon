//
//  PokemonListItemViewModel.swift
//  EZPokemon
//
//  Created by Luca Celiento on 30/10/2020.
//

import Foundation
import RxSwift
import Utilities

protocol PokemonDetailProtocol {
    func getPokemonDetail(id: Int) -> Observable<PokemonDetail>
    func getPokemonDetail(name: String) -> Observable<PokemonDetail>
    func getPokemonSpeciesDetail(name: String) -> Observable<PokemonSpeciesDetail>
}

protocol PokemonSpriteProtocol {
    func getPokemonImage(url: String) -> Observable<UIImage>
}

class PokemonListItemViewModel {
    
    let pokemonListItem: PokemonListItem

    lazy var name = Observable<String>.just(pokemonListItem.name.uppercased())
    lazy var image = BehaviorSubject<UIImage>(value: UIImage())
    var isLoading = BehaviorSubject<Bool>(value: false)
    
    var pokemonDetail: PokemonDetail?
    
    func fetchData() {
        isLoading.onNext(true)
        pokemonDetailService.getPokemonDetail(name: pokemonListItem.name).subscribe(onNext: { [weak self] pokemonDetail in
            guard let self = self else { return }
            self.pokemonDetail = pokemonDetail
            guard let frontDefaultURL = pokemonDetail.sprites.front_default else {
                self.isLoading.onNext(false)
                return self.image.onNext(UIImage.Named.missingno)
            }
            self.pokemonSpriteService.getPokemonImage(url: frontDefaultURL).subscribe { event in
                self.isLoading.onNext(false)
                switch event {
                case .next(let image):
                    self.image.onNext(image)
                default:
                    self.image.onNext(UIImage.Named.missingno)
                }
            }.disposed(by: self.disposeBag)
        }).disposed(by: disposeBag)
    }
    
    init(pokemonListItem: PokemonListItem, pokemonDetailService: PokemonDetailProtocol, pokemonSpriteService: PokemonSpriteProtocol) {
        self.pokemonListItem = pokemonListItem
        self.pokemonDetailService = pokemonDetailService
        self.pokemonSpriteService = pokemonSpriteService
    }
    
    // MARK: Private
    
    private let disposeBag = DisposeBag()
    private let pokemonDetailService: PokemonDetailProtocol
    private let pokemonSpriteService: PokemonSpriteProtocol
}
