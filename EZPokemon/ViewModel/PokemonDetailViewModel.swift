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
        case image(viewModel: ImageAndTypeViewModel)
        case header(viewModel: HeaderViewModel)
        case description(viewModel: DescriptionViewModel)
        case informations(viewModel: InformationsViewModel)
        case sprites(viewModel: SpritesViewModel)
//        case abilities(viewModel: AbilitiesViewModel)
        case stats(viewModel: StatsViewModel)
    }
    
//    let game_indices: [GameIndex]
//    let moves: [PokemonMove]

    lazy var name = Observable<String>.just(pokemonListItem.name.capitalized)
    var message = PublishSubject<String>()
    var dataSource = BehaviorSubject<[DataSource]>(value: [])
    var isLoading = PublishSubject<Bool>()
        
    func fetchData() {
        isLoading.onNext(true)
        guard let pokemonDetail = pokemonDetail else {
            return pokemonDetailService.getPokemonDetail(name: pokemonListItem.name).subscribe { [weak self] event in
                guard let self = self else { return }
                switch event {
                case .next(let detail):
                    self.pokemonDetail = detail
                    self.fetchData()
                case .error:
                    self.isLoading.onNext(false)
                    self.message.onNext("Error occurred, try again later.")
                default: break
                }
            }.disposed(by: disposeBag)
        }
        pokemonDetailService.getPokemonSpeciesDetail(name: pokemonListItem.name).subscribe { [weak self] event in
            guard let self = self else { return }
            self.isLoading.onNext(false)
            switch event {
            case .next(let pokemonSpeciesDetail):
                var data: [DataSource] = [
                    .image(viewModel: ImageAndTypeViewModel(url: pokemonDetail.sprites.front_default, types: pokemonDetail.types, pokemonSpriteService: self.pokemonSpriteService)),
                    .header(viewModel: HeaderViewModel(header: "DESCRIPTION", color: pokemonSpeciesDetail.color)),
                    .description(viewModel: DescriptionViewModel(pokemonSpeciesDetail: pokemonSpeciesDetail)),
                    .informations(viewModel: InformationsViewModel(pokemonDetail: pokemonDetail)),
                ]
                if !pokemonDetail.sprites.isEmpty {
                    data.append(contentsOf: [
                        .header(viewModel: HeaderViewModel(header: "SPRITES", color: pokemonSpeciesDetail.color)),
                        .sprites(viewModel: SpritesViewModel(sprites: pokemonDetail.sprites, pokemonSpriteService: self.pokemonSpriteService))
                    ])
                }
                data.append(contentsOf: [
                    .header(viewModel: HeaderViewModel(header: "STATS", color: pokemonSpeciesDetail.color)),
                    .stats(viewModel: StatsViewModel(stats: pokemonDetail.stats))
                ])
                self.dataSource.onNext(data)
            case .error:
                var data: [DataSource] = [
                    .image(viewModel: ImageAndTypeViewModel(url: pokemonDetail.sprites.front_default, types: pokemonDetail.types, pokemonSpriteService: self.pokemonSpriteService)),
                    .informations(viewModel: InformationsViewModel(pokemonDetail: pokemonDetail))
                ]
                if !pokemonDetail.sprites.isEmpty {
                    data.append(contentsOf: [
                        .header(viewModel: HeaderViewModel(header: "SPRITES", color: nil)),
                        .sprites(viewModel: SpritesViewModel(sprites: pokemonDetail.sprites, pokemonSpriteService: self.pokemonSpriteService))
                    ])
                }
                data.append(contentsOf: [
                    .header(viewModel: HeaderViewModel(header: "STATS", color: nil)),
                    .stats(viewModel: StatsViewModel(stats: pokemonDetail.stats))
                ])
                self.dataSource.onNext(data)
            default: break
            }
        }.disposed(by: disposeBag)
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
