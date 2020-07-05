//
//  HeaderCell.swift
//  MovieShelf
//
//  Created by Joseph Bouhanef on 2020-06-29.
//  Copyright © 2020 Joseph Bouhanef. All rights reserved.
//

import UIKit

class HeaderCell: UICollectionReusableView {
    
    let imageView = UIImageView(cornerRadius: 10)
    let heavyLabel = UILabel(text: "Images", font: .boldSystemFont(ofSize: 25), numberOfLines: 0)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        imageView.fillSuperview()
        setupGradientLayer()
    }
    
    fileprivate func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.5, 1]
        
        //layer.addSublayer(gradientLayer)
        let gradientContentView = UIView()
        addSubview(gradientContentView)
        gradientContentView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        gradientContentView.layer.addSublayer(gradientLayer)
        //this is a static frame
        gradientLayer.frame = self.bounds
        
        gradientLayer.frame.origin.y -= bounds.height
        
        heavyLabel.font = .systemFont(ofSize: 28, weight: .heavy)
        heavyLabel.textColor = .white
        
        addSubview(heavyLabel)
        heavyLabel.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 14, bottom: 14, right: 14))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
