//
//  PokemonSpriteService.swift
//  EZPokemon
//
//  Created by Luca Celiento on 01/11/2020.
//

import Foundation
import RxSwift
import Utilities

class PokemonSpriteService: PokemonSpriteProtocol {
    
    func getPokemonImage(url: String) -> Observable<UIImage> {
        
        return Observable.create { observer -> Disposable in
            
            if let cachedImage = self.imageCache.object(forKey: url as NSString) {
                observer.onNext(cachedImage)
                return Disposables.create()
            } else {
                return self.networkManager.executeRequest(url: url, method: "GET").subscribe { event in
                    switch event {
                    case .next(let data):
                        guard let image = UIImage(data: data) else {
                            observer.onError(Utilities.NetworkManager.NetworkManagerError.generic)
                            return
                        }
                        self.imageCache.setObject(image, forKey: url as NSString)
                        observer.onNext(image)
                    case .error(let error):
                        observer.onError(error)
                    case .completed:
                        observer.onCompleted()
                    }
                }
            }
        }
    }
    
    // MARK: - Private
    
    private let networkManager = Utilities.NetworkManager()
    private let imageCache = NSCache<NSString, UIImage>()
}

