//
//  ImageCastCell.swift
//  MovieShelf
//
//  Created by Joseph Bouhanef on 2020-11-10.
//  Copyright © 2020 Joseph Bouhanef. All rights reserved.
//

import Foundation

import UIKit

class ImageCastCell: UICollectionViewCell {
    
    let horizontalController = CastImageController()
    let sectionTitle = UILabel(text: "Images", font: .boldSystemFont(ofSize: 25))
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageCastCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func getSearchRequest(castResult: Cast? = nil) -> Self {
        horizontalController.castResult = castResult!
        horizontalController.getSetup()
        
        return self
    }
}

fileprivate extension ImageCastCell {
    
    func setupImageCastCell() {
        sectionTitle.textColor = .systemPurple
        addSubview(horizontalController.view)
        addSubview(sectionTitle)
        horizontalController.view.fillSuperview()
        
        sectionTitle.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 5, bottom: 10, right: 10))
        horizontalController.view.anchor(top: sectionTitle.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 20, left: 5, bottom: 0, right: 0))
    }
}
