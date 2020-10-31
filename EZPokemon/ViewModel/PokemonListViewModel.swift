//
//  PokemonListViewModel.swift
//  EZPokemon
//
//  Created by Luca Celiento on 29/10/2020.
//

import RxSwift

protocol PokemonListProtocol {
    func getPokemonList(offset: Int) -> Observable<[PokemonListItem]>
}

struct PokemonListViewModel {
    
    init(pokemonListService: PokemonListProtocol) {
        self.pokemonListService = pokemonListService
    }
    
    var pokemonListItemViewModels = PublishSubject<[PokemonListItemViewModel]>()
    var error = PublishSubject<Bool>()
    var isLoading = PublishSubject<Bool>()
    
    func fetchPokemonListItemViewModel() {
        isLoading.onNext(true)
        pokemonListService.getPokemonList(offset: currentOffset).map{$0.map{PokemonListItemViewModel(pokemonListItem: $0)}}.subscribe { event in
            self.isLoading.onNext(false)
            switch event {
            case .next(let viewModels):
                self.pokemonListItemViewModels.onNext(viewModels)
            case .error:
                self.error.onNext(true)
            default: break
            }
        }.disposed(by: disposeBag)
    }
    
    // MARK: Private
    
    private let pokemonListService: PokemonListProtocol
    private let disposeBag = DisposeBag()
    private var currentOffset = 20
}
