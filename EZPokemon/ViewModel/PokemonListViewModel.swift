//
//  PokemonListViewModel.swift
//  EZPokemon
//
//  Created by Luca Celiento on 29/10/2020.
//

import RxSwift

protocol PokemonListProtocol {
    func getPokemonList(limit: Int, offset: Int) -> Observable<[GetPokemonListItem]>
}

class PokemonListViewModel {
    
    init(pokemonListService: PokemonListProtocol) {
        self.pokemonListService = pokemonListService
    }
    
    var title = Observable<String>.just("Pokémon")
    var pokemonListItemViewModels = PublishSubject<[PokemonListItemViewModel]>()
    var message = PublishSubject<Bool>()
    var isLoading = PublishSubject<Bool>()
    
    func fetchPokemonListItemViewModel() {
        isLoading.onNext(true)
        pokemonListService
            .getPokemonList(limit: limit, offset: currentOffset)
            .map{$0.map{PokemonListItemViewModel(pokemonListItem: $0)}}
            .subscribe { [weak self] event in
                guard let self = self else { return }
                self.isLoading.onNext(false)
                switch event {
                case .next(let viewModels):
                    if !viewModels.isEmpty {
                        self.currentOffset += self.limit
                    }
                    self.pokemonListItemViewModels.onNext(viewModels)
                case .error(let error):
                    self.handle(error: error)
                default: break
                }
            }.disposed(by: disposeBag)
    }
    
    // MARK: Private
    
    private let pokemonListService: PokemonListProtocol
    private let disposeBag = DisposeBag()
    private let limit = 20
    private var currentOffset = 0
    
    private func handle(error: Error) {
        
    }
}
