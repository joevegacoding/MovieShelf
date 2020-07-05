//
//  AppHeaderCell.swift
//  MovieShelf
//
//  Created by Joseph Bouhanef on 2020-07-03.
//  Copyright © 2020 Joseph Bouhanef. All rights reserved.
//

import UIKit

class MovieHeaderCell: UICollectionViewCell {
    
    let movieTitleLabel = UILabel(text: "Titanic", font: .boldSystemFont(ofSize: 15))
    let descriptionLabel = UILabel(text: "A movie about a boat sinking because of an iceberg. A movie about a boat sinking because of an iceberg", font: .systemFont(ofSize: 17), numberOfLines: 2)
    let imageView = UIImageView(cornerRadius: 8)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupMovieHeaderCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MovieHeaderCell {
    
    func setupMovieHeaderCell() {
        
        movieTitleLabel.textColor = .systemPurple
        movieTitleLabel.font = UIFont(name: "Avenir-Heavy" , size: 20)
        descriptionLabel.font = UIFont(name: "AvenirNext", size: 17)
        let stackView = VerticalStackView(arrangeSubViews: [movieTitleLabel, descriptionLabel, imageView], spacing: 10)
        imageView.backgroundColor = .red
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 16, left: 10, bottom: 5, right: 0))
    }
}
