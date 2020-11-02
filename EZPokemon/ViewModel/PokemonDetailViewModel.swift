//
//  PokemonDetailViewModel.swift
//  EZPokemon
//
//  Created by Luca Celiento on 01/11/2020.
//

import Foundation
import RxSwift

class PokemonDetailViewModel {
    
    enum DataSource {
        case header(header: String)
        case informations(viewModel: InformationsViewModel)
        case sprites(viewModel: SpritesViewModel)
        case abilities(viewModel: AbilitiesViewModel)
    }

    lazy var name = Observable<String>.just(pokemonListItem.name.uppercased())
    var message = PublishSubject<String>()
    var dataSource = BehaviorSubject<[DataSource]>(value: [])
        
    func fetchData() {
        guard let pokemonDetail = pokemonDetail else {
            return pokemonDetailService.getPokemonDetail(name: pokemonListItem.name).subscribe { [weak self] event in
                guard let self = self else { return }
                switch event {
                case .next(let detail):
                    self.pokemonDetail = detail
                    self.fetchData()
                case .error:
                    self.message.onNext("Error occurred, try again later.")
                default: break
                }
            }.disposed(by: disposeBag)
        }
        dataSource.onNext([
            .informations(viewModel: InformationsViewModel(pokemonDetail: pokemonDetail, pokemonSpriteService: pokemonSpriteService)),
            .header(header: "SPRITES"),
            .sprites(viewModel: SpritesViewModel(sprites: pokemonDetail.sprites, pokemonSpriteService: pokemonSpriteService)),
            .header(header: "ABILITIES"),
            .abilities(viewModel: AbilitiesViewModel(pokemonAbilities: pokemonDetail.abilities))
        ])
    }
    
    init(pokemonListItem: PokemonListItem, pokemonDetail: PokemonDetail?, pokemonDetailService: PokemonDetailProtocol, pokemonSpriteService: PokemonSpriteProtocol) {
        self.pokemonListItem = pokemonListItem
        self.pokemonDetail = pokemonDetail
        self.pokemonDetailService = pokemonDetailService
        self.pokemonSpriteService = pokemonSpriteService
    }
    
    // MARK: Private
    
    private let pokemonListItem: PokemonListItem
    private var pokemonDetail: PokemonDetail?
    private let pokemonDetailService: PokemonDetailProtocol
    private let pokemonSpriteService: PokemonSpriteProtocol
    private let disposeBag = DisposeBag()
}
