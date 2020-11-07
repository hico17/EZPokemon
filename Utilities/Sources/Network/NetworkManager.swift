//
//  File.swift
//  
//
//  Created by Luca Celiento on 29/10/2020.
//

import Foundation
import RxSwift

public extension Utilities {
    
    class NetworkManager {
        
        public func executeRequest<T: Decodable>(url: String, method: String, dataType: T.Type) -> Observable<T> {
            
            return Observable.create { observer -> Disposable in
                
                guard let url = URL(string: url) else {
                    observer.onError(NetworkManagerError.urlCreationError)
                    return Disposables.create()
                }
                
                var urlRequest = URLRequest(url: url)
                urlRequest.httpMethod = method
                
                let task = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, response, error in
                    guard let self = self else {
                        return observer.onError(NetworkManagerError.generic)
                    }
                    if let error = error {
                        if (error as NSError).code == -1009 {
                            return observer.onError(NetworkManagerError.offline)
                        }
                        return observer.onError(error)
                    }
                    guard let data = data else {
                        return observer.onError(NetworkManagerError.missingData)
                    }
                    if let httpResponse = response as? HTTPURLResponse {
                        if httpResponse.statusCode > 299, httpResponse.statusCode < 200 {
                            return observer.onError(NetworkManagerError.notValidStatusCode)
                        }
                    }
                    let decodedData = self.decoder.decode(T.self, from: data)
                    decodedData.subscribe(observer).disposed(by: self.disposeBag)
                }
                
                task.resume()
                return Disposables.create {
                    task.cancel()
                }
            }
        }
        
        public func executeRequest(url: String, method: String) -> Observable<Data> {
            
            return Observable.create { observer -> Disposable in
                
                guard let url = URL(string: url) else {
                    observer.onError(NetworkManagerError.urlCreationError)
                    return Disposables.create()
                }
                
                var urlRequest = URLRequest(url: url)
                urlRequest.httpMethod = method
                
                let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                    if let error = error {
                        return observer.onError(error)
                    }
                    guard let data = data else {
                        return observer.onError(NetworkManagerError.missingData)
                    }
                    if let httpResponse = response as? HTTPURLResponse {
                        if httpResponse.statusCode > 299, httpResponse.statusCode < 200 {
                            return observer.onError(NetworkManagerError.notValidStatusCode)
                        }
                    }
                    observer.onNext(data)
                }
                
                task.resume()
                return Disposables.create {
                    task.cancel()
                }
            }
        }
        
        public init() {}
        
        // MARK: Private
        
        private let decoder = Utilities.Decoder()
        private let disposeBag = DisposeBag()
    }
}
