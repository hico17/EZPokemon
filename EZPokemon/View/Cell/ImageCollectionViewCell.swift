//
//  ImageCollectionViewCell.swift
//  EZPokemon
//
//  Created by Luca Celiento on 01/11/2020.
//

import UIKit
import Utilities

class ImageCollectionViewCell: UICollectionViewCell, Reusable {
    
    var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        image = nil
    }
    
    // MARK: Private

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private func commonInit() {
        addSubviews()
        addConstraints()
    }
}

// MARK: - CodeDesignable

extension ImageCollectionViewCell: CodeDesignable {
    
    func addSubviews() {
        contentView.addSubview(imageView)
    }
    
    func addConstraints() {
        imageView.constraint(to: contentView)
    }
}
