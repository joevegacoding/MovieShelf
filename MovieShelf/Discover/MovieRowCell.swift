//
//  MovieRowCell.swift
//  MovieShelf
//
//  Created by Joseph Bouhanef on 2020-06-22.
//  Copyright © 2020 Joseph Bouhanef. All rights reserved.
//

import UIKit

extension UIButton {
    
    convenience init(title: String) {
        
        self.init(type: .system)
        self.setTitle(title, for: .normal)
    }
}

class MovieRowCell: UICollectionViewCell {
    
    let imageView = UIImageView(cornerRadius: 8)
    let titleLabel = UILabel(text: "Titanic", font: .systemFont(ofSize: 20))
    let releaseDateLabel = UILabel(text: "1997", font: .systemFont(ofSize: 13))
    let ratingLabel = UILabel(text: "4.8", font: .systemFont(ofSize: 13))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

fileprivate extension MovieRowCell {
    
    func setupCell() {
        imageView.constrainWidth(constant: 135)
        imageView.constrainHeight(constant: 220)
        ratingLabel.textColor = .systemPurple
        titleLabel.font = UIFont(name: "Avenir-Heavy", size: 20)
        ratingLabel.font = UIFont(name: "Avenir-Heavy", size: 20)
        releaseDateLabel.font = UIFont(name: "Avenir", size: 20)
        
        let stackView = UIStackView(arrangedSubviews: [imageView, VerticalStackView(arrangeSubViews: [titleLabel, releaseDateLabel, ratingLabel] ,spacing: 4)])
        
        stackView.spacing = 16
        stackView.alignment = .center
        addSubview(stackView)
        stackView.fillSuperview()
    }
}
