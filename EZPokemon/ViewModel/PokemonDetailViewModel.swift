//
//  PokemonDetailViewModel.swift
//  EZPokemon
//
//  Created by Luca Celiento on 01/11/2020.
//

import Foundation
import RxSwift

struct PokemonDetailViewModel {
    
    enum DataSource {
        case header(header: String)
    }

    lazy var name = Observable<String>.just(pokemonListItem.name.uppercased())
    var dataSource = BehaviorSubject<[DataSource]>(value: [])
    lazy var spriteImages = BehaviorSubject<[UIImage]>(value: [UIImage.Named.missingno])
        
    func fetchData() {
        
    }
    
    init(pokemonListItem: PokemonListItem, pokemonDetail: PokemonDetail?, pokemonDetailService: PokemonDetailProtocol) {
        self.pokemonListItem = pokemonListItem
        self.pokemonDetail = pokemonDetail
        self.pokemonDetailService = pokemonDetailService
    }
    
    // MARK: Private
    
    private let pokemonListItem: PokemonListItem
    private var pokemonDetail: PokemonDetail?
    private let pokemonDetailService: PokemonDetailProtocol
    private let disposeBag = DisposeBag()
}
