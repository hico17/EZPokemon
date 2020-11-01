//
//  PokemonDetailService.swift
//  EZPokemon
//
//  Created by Luca Celiento on 31/10/2020.
//

import Foundation
import RxSwift
import Utilities

class PokemonDetailService: PokemonDetailProtocol {

    func getPokemonDetail(id: Int) -> Observable<PokemonDetail> {
        return networkManager.executeRequest(url: "https://pokeapi.co/api/v2/pokemon/\(id)", method: "GET", dataType: PokemonDetail.self)
    }
    
    func getPokemonDetail(name: String) -> Observable<PokemonDetail> {
        return networkManager.executeRequest(url: "https://pokeapi.co/api/v2/pokemon/\(name)", method: "GET", dataType: PokemonDetail.self)
    }
    
    func getPokemonImage(url: String) -> Observable<UIImage> {
        return Observable.create { observer -> Disposable in
            return self.networkManager.executeRequest(url: url, method: "GET").subscribe { event in
                switch event {
                case .next(let data):
                    observer.onNext(UIImage(data: data) ?? UIImage())
                case .error(let error):
                    observer.onError(error)
                case .completed:
                    observer.onCompleted()
                }
            }
        }
    }
    
    private let networkManager = Utilities.NetworkManager()
}
