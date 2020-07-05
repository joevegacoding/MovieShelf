//
//  CastDetailsCell.swift
//  MovieShelf
//
//  Created by Joseph Bouhanef on 2020-06-25.
//  Copyright © 2020 Joseph Bouhanef. All rights reserved.
//

import UIKit

class CastDetailsCell: UICollectionViewCell {
    
    let profileImageView = UIImageView(cornerRadius: 10)
    let castLabel = UILabel(text: "George Clooney", font: .boldSystemFont(ofSize: 18), numberOfLines: 0)
    let characterLabel = UILabel(text: "Ocean", font: .boldSystemFont(ofSize: 17), numberOfLines: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        characterLabel.textColor = .systemPink
        
        profileImageView.constrainWidth(constant: 130)
        profileImageView.constrainHeight(constant: 180)
        
        let stackView = VerticalStackView(arrangeSubViews: [
            UIStackView(arrangedSubviews: [
                profileImageView,
                VerticalStackView(arrangeSubViews: [
                    UIView()
                ], spacing: 5)
            ], customSpacing: 5),
            castLabel,
            characterLabel
        ], spacing: 5)
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 3, left: 5, bottom: 5, right: 25))
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
}
