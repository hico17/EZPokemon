//
//  File.swift
//  
//
//  Created by Luca Celiento on 31/10/2020.
//

import Foundation

public protocol Reusable {
    static var reusableIdentifier: String { get }
}

public extension Reusable {
    static var reusableIdentifier: String {
        return String(describing: type(of: self))
    }
}
