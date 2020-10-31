//
//  AnimatedLogoViewController.swift
//  EZPokemon
//
//  Created by Luca Celiento on 29/10/2020.
//

import UIKit

protocol CodeDesignable {
    func addSubviews()
    func addConstraints()
}

class AnimatedLogoViewController: UIViewController {
    
    init(viewModel: AnimatedLogoViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        addConstraints()
        bindData()
    }
    
    // MARK: Private
    
    private var viewModel: AnimatedLogoViewModel
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private func bindData() {
        
    }
}

// MARK: - CodeDesignable

extension AnimatedLogoViewController: CodeDesignable {
    
    func addSubviews() {
        view.addSubview(logoImageView)
    }
    
    func addConstraints() {
        
    }
}
