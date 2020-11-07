//
//  File.swift
//  
//
//  Created by Luca Celiento on 31/10/2020.
//

import UIKit

public extension UITableView {
    
    func register<T: UITableViewCell>(_ cellType: T.Type) where T: Reusable {
        register(cellType, forCellReuseIdentifier: cellType.reusableIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(_ cellType: T.Type, for indexPath: IndexPath) -> T where T: Reusable {
        guard let cell = dequeueReusableCell(withIdentifier: T.reusableIdentifier, for: indexPath) as? T else {
            fatalError("Error: cannot dequeue cell of type \(T.self) at indexPath \(indexPath)")
        }
        return cell
    }
}
