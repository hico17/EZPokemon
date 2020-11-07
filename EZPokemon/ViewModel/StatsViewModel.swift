//
//  StatsViewModel.swift
//  EZPokemon
//
//  Created by Luca Celiento on 03/11/2020.
//

import Foundation
import RxSwift

struct StatsViewModel {
    
    let viewModels: Observable<[StatViewModel]>
    
    init(stats: [PokemonStat]) {
        self.viewModels = .just(stats.map{StatViewModel(stat: $0)})
    }
}
