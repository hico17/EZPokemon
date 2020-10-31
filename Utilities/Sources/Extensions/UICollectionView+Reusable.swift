//
//  File.swift
//  
//
//  Created by Luca Celiento on 31/10/2020.
//

import UIKit

public extension UICollectionView {
    
    func register<T: UICollectionViewCell>(_ cellType: T.Type) where T: Reusable {
        register(cellType, forCellWithReuseIdentifier: cellType.reusableIdentifier)
    }
}
