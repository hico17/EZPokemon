//
//  PokemonListViewModel.swift
//  EZPokemon
//
//  Created by Luca Celiento on 29/10/2020.
//

import RxSwift
import Utilities

protocol PokemonListProtocol {
    func getPokemonList(limit: Int, offset: Int) -> Observable<[GetPokemonListItem]>
}

class PokemonListViewModel {
    
    var title = Observable<String>.just("Pokémon")
    var pokemonListItemViewModels = BehaviorSubject<[PokemonListItemViewModel]>(value: [])
    var message = PublishSubject<String>()
    var isLoading = BehaviorSubject<Bool>(value: false)
    
    func fetchPokemonListItemViewModel() {
        isLoading.onNext(true)
        pokemonListService
            .getPokemonList(limit: limit, offset: currentOffset)
            .map{$0.map{PokemonListItemViewModel(pokemonListItem: $0, pokemonDetailService: self.pokemonDetailService)}}
            .subscribe { [weak self] event in
                guard let self = self else { return }
                self.isLoading.onNext(false)
                switch event {
                case .next(let viewModels):
                    if !viewModels.isEmpty {
                        self.currentOffset += self.limit
                    }
                    if var currentViewModels = try? self.pokemonListItemViewModels.value() {
                        currentViewModels.append(contentsOf: viewModels)
                        self.pokemonListItemViewModels.onNext(currentViewModels)
                    } else {
                        self.pokemonListItemViewModels.onNext(viewModels)
                    }
                case .error(let error):
                    self.handle(error: error)
                default: break
                }
            }.disposed(by: disposeBag)
    }
    
    func didScrollToEnd() {
        guard let loading = try? isLoading.value(), !loading else {
            return
        }
        fetchPokemonListItemViewModel()
    }
    
    func willShow(viewModelAtIndex index: Int) {
        if let item = try? pokemonListItemViewModels.value()[index], item.pokemonDetail == nil {
            item.fetchData()
        }
    }
    
    func didSelect(viewModel: PokemonListItemViewModel) {
        // TODO
    }
    
    init(pokemonListService: PokemonListProtocol) {
        self.pokemonListService = pokemonListService
    }
    
    // MARK: Private
    
    private let pokemonListService: PokemonListProtocol
    private let pokemonDetailService = PokemonDetailService()
    private let disposeBag = DisposeBag()
    private let limit = 20
    private var currentOffset = 0
    
    private func handle(error: Error) {
        switch error {
        case Utilities.NetworkManager.NetworkManagerError.offline:
            message.onNext("The connection appear to be offline ☹️.\nTry to switch connection or find a better place 🤗")
        default:
            message.onNext("Something has gone wrong ☹️")
        }
    }
}
