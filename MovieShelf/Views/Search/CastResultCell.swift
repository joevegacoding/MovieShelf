//
//  CastCell.swift
//  MovieShelf
//
//  Created by Joseph Bouhanef on 2020-06-25.
//  Copyright © 2020 Joseph Bouhanef. All rights reserved.
//

import UIKit

class CastCell: UICollectionViewCell {
    
    let castBigTitleLabel = UILabel(text: "Cast", font: .boldSystemFont(ofSize: 25))
    let horizontalController = CastHorizontalController()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getSearchRequest(searchResult: Result? = nil) -> Self {
        horizontalController.searchResult = searchResult!
        horizontalController.getSetup()
        return self
    }
}

fileprivate extension CastCell {
    
     func setupCell() {
        addSubview(horizontalController.view)
        addSubview(castBigTitleLabel)
        castBigTitleLabel.textColor = .systemPurple
        castBigTitleLabel.font = UIFont(name: "Avenir-Heavy" , size: 25)
        castBigTitleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 20))
        
        horizontalController.view.anchor(top: castBigTitleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 15, left: 0, bottom: 0, right: 0))
    }
}
