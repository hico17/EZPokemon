//
//  File.swift
//  
//
//  Created by Luca Celiento on 31/10/2020.
//

import Foundation

public protocol Configurable {
    associatedtype Configuration
    func configure(with configuration: Configuration)
}
