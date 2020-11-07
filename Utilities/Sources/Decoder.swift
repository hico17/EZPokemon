//
//  File.swift
//  
//
//  Created by Luca Celiento on 29/10/2020.
//

import Foundation
import RxSwift

public extension Utilities {
    
    class Decoder {
        
        public func decode<T>(_ type: T.Type, from data: Data) -> Observable<T> where T: Decodable {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            return Observable.create { observer -> Disposable in
                do {
                    let decodedData = try decoder.decode(T.self, from: data)
                    observer.onNext(decodedData)
                } catch {
                    observer.onError(error)
                }
                return Disposables.create()
            }
        }
        
        public init() {}
    }
}
