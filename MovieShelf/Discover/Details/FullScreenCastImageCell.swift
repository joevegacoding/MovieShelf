//
//  FullScreenImage.swift
//  MovieShelf
//
//  Created by Joseph Bouhanef on 2020-07-30.
//  Copyright © 2020 Joseph Bouhanef. All rights reserved.
//

import UIKit

class FullScreenCastImageCell: UICollectionViewCell {
    
    let horizontalFullScreenController = FullScreenCastImageController()
    let actorFullScreenImageView = UIImageView(cornerRadius: 1)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .blue
        
        addSubview(actorFullScreenImageView)
        actorFullScreenImageView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
