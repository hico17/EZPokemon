//
//  File.swift
//  
//
//  Created by Luca Celiento on 31/10/2020.
//

import UIKit

public extension UIView {
    
    func constraint(to view: UIView, padding: UIEdgeInsets = .zero) {
        NSLayoutConstraint.activateWithoutResizingMasks([
            leftAnchor.constraint(equalTo: view.leftAnchor, constant: padding.left),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: padding.bottom),
            rightAnchor.constraint(equalTo: view.rightAnchor, constant: padding.right),
            topAnchor.constraint(equalTo: view.topAnchor, constant: padding.top),
        ])
    }
}
