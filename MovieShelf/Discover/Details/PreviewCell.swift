//
//  VideoPreviewCell.swift
//  MovieShelf
//
//  Created by Joseph Bouhanef on 2020-06-27.
//  Copyright © 2020 Joseph Bouhanef. All rights reserved.
//

import UIKit

class PreviewCell: UICollectionViewCell {
    
    let horizontalController = PreviewController()
    let sectionTitle = UILabel(text: "Images", font: .boldSystemFont(ofSize: 25))
    
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

fileprivate extension PreviewCell {
    
    func setupCell() {
        sectionTitle.font = UIFont(name: "Avenir-Heavy" , size: 25)
        sectionTitle.textColor = .systemPurple
        addSubview(horizontalController.view)
        addSubview(sectionTitle)
        
        sectionTitle.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 20, left: 5, bottom: 20, right: 20))
        
        horizontalController.view.anchor(top: sectionTitle.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 10, left: 0, bottom: 10, right: 0))
    }
}
