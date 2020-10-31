//
//  File.swift
//  
//
//  Created by Luca Celiento on 29/10/2020.
//

import Foundation

extension Utilities.NetworkManager {
    
    enum NetworkManagerError: LocalizedError {
        case urlCreationError
        case missingData
        case notValidStatusCode
        case generic
    }
}
