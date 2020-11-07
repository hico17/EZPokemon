//
//  StatViewModel.swift
//  EZPokemon
//
//  Created by Luca Celiento on 03/11/2020.
//

import Foundation
import RxSwift

struct StatViewModel {
    
    lazy var name = Observable<String>.just(getStatName())
    lazy var baseStat = Observable<String>.just(String(stat.base_stat))
    
    init(stat: PokemonStat) {
        self.stat = stat
    }
    
    private let stat: PokemonStat
    
    private func getStatName() -> String {
        return stat.stat.name.split(separator: "-").map{String($0)}.joined(separator: " ").uppercased()
    }
}
