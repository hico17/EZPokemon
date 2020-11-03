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
        case image(viewModel: SpriteViewModel)
        case header(header: String)
        case informations(viewModel: InformationsViewModel)
        case sprites(viewModel: SpritesViewModel)
        case abilities(viewModel: AbilitiesViewModel)
        case stats(viewModel: StatsViewModel)
    }
    
//    let types: [PokemonType]
//    let game_indices: [GameIndex]
//    let moves: [PokemonMove]

    lazy var name = Observable<String>.just(pokemonListItem.name.capitalized)
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
            .image(viewModel: SpriteViewModel(url: pokemonDetail.sprites.front_default, pokemonSpriteService: pokemonSpriteService)),
            .informations(viewModel: InformationsViewModel(pokemonDetail: pokemonDetail)),
            .header(header: "SPRITES"),
            .sprites(viewModel: SpritesViewModel(sprites: pokemonDetail.sprites, pokemonSpriteService: pokemonSpriteService)),
            .header(header: "STATS"),
            .stats(viewModel: StatsViewModel(stats: pokemonDetail.stats)),
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
