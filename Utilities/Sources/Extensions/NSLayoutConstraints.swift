//
//  File.swift
//  
//
//  Created by Luca Celiento on 31/10/2020.
//

import UIKit

public extension NSLayoutConstraint {

    static func activateWithoutResizingMasks(_ constraints: [NSLayoutConstraint]) {
        constraints.forEach {
            if let view = $0.firstItem as? UIView {
                 view.translatesAutoresizingMaskIntoConstraints = false
            }
        }
        activate(constraints)
    }
}
