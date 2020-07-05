//
//  MovieDetailsCell.swift
//  MovieShelf
//
//  Created by Joseph Bouhanef on 2020-06-24.
//  Copyright © 2020 Joseph Bouhanef. All rights reserved.
//

import UIKit

class MovieDetailsCell: UICollectionViewCell {
    
    let moviePosterImageView = UIImageView(cornerRadius: 16)
    let titleLabel = UILabel(text: "", font: .boldSystemFont(ofSize: 24), numberOfLines: 0)
    let castLabel = UILabel(text:"Description", font: .boldSystemFont(ofSize: 20))
    let descriptionTextLabel = UILabel(text: "Leonardo DiCaprio", font: .systemFont(ofSize: 16), numberOfLines: 0)
    let releaseDateLabel = UILabel(text: "1997", font: .systemFont(ofSize: 16), numberOfLines: 0)
    let ratingLabel = UILabel(text: "4.8", font: .systemFont(ofSize: 16), numberOfLines: 0)
    let genreLabel = UILabel(text: "Action", font: .systemFont(ofSize: 16), numberOfLines: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupFonts()
        setUpMovieDetailCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MovieDetailsCell {
    
    fileprivate func setUpMovieDetailCell() {
        let stackView = VerticalStackView(arrangeSubViews: [
            UIStackView(arrangedSubviews: [
                moviePosterImageView,
                VerticalStackView(arrangeSubViews: [
                    titleLabel, releaseDateLabel, ratingLabel, genreLabel,
                    UIView()
                ], spacing: 12)
            ], customSpacing: 20),
            castLabel,
            descriptionTextLabel
        ], spacing: 12)
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 5, left: 10, bottom: 10, right: 20))
    }
    
    func setupFonts() {
        
        moviePosterImageView.constrainWidth(constant: 150)
        moviePosterImageView.constrainHeight(constant: 220)
        
        releaseDateLabel.constrainHeight(constant: 32)
        releaseDateLabel.font = UIFont(name: "Avenir-Medium" , size: 20)
        
        ratingLabel.constrainHeight(constant: 32)
        ratingLabel.font = UIFont(name: "Avenir-Medium" , size: 20)
        
        genreLabel.font = UIFont(name: "Avenir-Medium" , size: 20)
        
        castLabel.textColor = .systemPurple
        castLabel.font = UIFont(name: "Avenir-Heavy" , size: 25)
        
        descriptionTextLabel.font = UIFont(name: "Avenir-Light" , size: 20)
    }
}

extension UIStackView {
    convenience init(arrangedSubviews: [UIView], customSpacing: CGFloat = 0) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.spacing = customSpacing
    }
}
