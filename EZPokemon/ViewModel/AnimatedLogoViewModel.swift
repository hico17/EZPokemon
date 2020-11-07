//
//  AnimatedLogoViewModel.swift
//  EZPokemon
//
//  Created by Luca Celiento on 30/10/2020.
//

import UIKit

protocol AnimatedLogoViewModelDelegate: class {
    func didFinishToShowLogo(_ sender: AnimatedLogoViewModel)
}

struct AnimatedLogoViewModel {
    
    init(delegate: AnimatedLogoViewModelDelegate) {
        self.delegate = delegate
    }
    
    var logoImage = UIImage(named: "") // TODO
    weak var delegate: AnimatedLogoViewModelDelegate?
    
    func startTimer() {
        
        // TODO
        
        delegate?.didFinishToShowLogo(self)
    }
    
    private var timer: Timer? // TODO
}
