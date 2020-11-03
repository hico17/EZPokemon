//
//  StatsViewModel.swift
//  EZPokemon
//
//  Created by Luca Celiento on 03/11/2020.
//

import Foundation
import RxSwift

struct StatsViewModel {
    
    lazy var viewModels = Observable<[StatViewModel]>.just(stats.map{StatViewModel(stat: $0)})
    
    init(stats: [PokemonStat]) {
        self.stats = stats
    }
    
    // MARK: - Private
    
    private let stats: [PokemonStat]
}
