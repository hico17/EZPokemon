//
//  HeaderViewModel.swift
//  EZPokemon
//
//  Created by Luca Celiento on 03/11/2020.
//

import Foundation
import RxSwift

struct HeaderViewModel {
    
    var header: Observable<String>
    var color: Observable<UIColor>
    
    init(header: String, color: Color) {
        self.header = .just(header)
        self.color = .just(UIColor.from(color: color))
    }
}
