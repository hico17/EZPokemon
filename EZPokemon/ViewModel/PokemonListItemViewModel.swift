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
    func getPokemonDetail(id: Int) -> Observable<GetPokemonDetail>
    func getPokemonDetail(name: String) -> Observable<GetPokemonDetail>
    func getPokemonImage(url: String) -> Observable<UIImage>
}

struct PokemonListItemViewModel {
    
    lazy var name = Observable<String>.just(pokemonListItem.name)
    var image = PublishSubject<UIImage>()
    var isLoading = PublishSubject<Bool>()
    
    func fetchData() {
        isLoading.onNext(true)
        pokemonDetailService.getPokemonDetail(name: pokemonListItem.name).subscribe(onNext: { detail in
            pokemonDetailService.getPokemonImage(url: detail.sprites.front_default).subscribe { event in
                self.isLoading.onNext(false)
                switch event {
                case .next(let image):
                    self.image.onNext(image)
                default: return
                }
            }.disposed(by: disposeBag)
        }).disposed(by: disposeBag)
    }
    
    init(pokemonListItem: GetPokemonListItem, pokemonDetailService: PokemonDetailProtocol) {
        self.pokemonListItem = pokemonListItem
        self.pokemonDetailService = pokemonDetailService
    }
    
    // MARK: Private
    
    private let disposeBag = DisposeBag()
    private let pokemonListItem: GetPokemonListItem
    private let pokemonDetailService: PokemonDetailProtocol
}
