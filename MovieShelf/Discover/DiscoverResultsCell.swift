//
//  DiscoverResultsCell.swift
//  MovieShelf
//
//  Created by Joseph Bouhanef on 2020-06-22.
//  Copyright © 2020 Joseph Bouhanef. All rights reserved.
//

import UIKit

class DiscoverResultsCell: UICollectionViewCell {
    
    var titleLabel = UILabel(text: "Category", font: .boldSystemFont(ofSize: 30))
    let seeAllButton = UILabel(text: "See All", font: .systemFont(ofSize: 18))
    
    let horizontalController = MoviesHorizontalController(mode: .small)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupDiscoverResultsCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


fileprivate extension DiscoverResultsCell {
    
     func setupDiscoverResultsCell() {
        titleLabel.textColor = .systemPink
        seeAllButton.textColor = .systemBlue
        
        let stackview = UIStackView(arrangedSubviews: [titleLabel, seeAllButton], customSpacing: 10)
        addSubview(stackview)
        
        stackview.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 13))
        
        addSubview(horizontalController.view)
        horizontalController.view.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
}
