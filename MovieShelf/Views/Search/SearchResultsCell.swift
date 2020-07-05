//
//  SearchResultsCell.swift
//  MovieShelf
//
//  Created by Joseph Bouhanef on 2020-06-22.
//  Copyright © 2020 Joseph Bouhanef. All rights reserved.
//

import UIKit


fileprivate func setupImageView() -> UIImageView {
    
    let iv = UIImageView()
    iv.widthAnchor.constraint(equalToConstant: 150).isActive = true
    iv.heightAnchor.constraint(equalToConstant: 220).isActive = true
    iv.layer.cornerRadius = 12
    iv.layer.borderWidth = 0.5
    iv.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
    iv.contentMode = .scaleAspectFill
    iv.clipsToBounds = true
    iv.image = UIImage(named: "today_icon")
    return iv
}

class SearchResultsCell: UICollectionViewCell {
    var movieResult: Result! {
        didSet {
            let url = URL(string: "https://image.tmdb.org/t/p/w500/\(movieResult.poster_path ?? "")")
            moviePosterImageView.sd_setImage(with: url)
            nameLabel.text = movieResult.original_title ?? ""
            releaseDate.text = movieResult.release_date ?? ""
            if let voteAverage = movieResult.vote_average {
                if voteAverage == 0 {
                    ratingsLabel.text = "N/A"
                } else {
                    ratingsLabel.text = String(format: "%.2f ⭐️", voteAverage)
                }
            }
        }
    }
    
    let moviePosterImageView : UIImageView = {
        
        return setupImageView()
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Movie Name"
        return label
    }()
    
    let releaseDate: UILabel = {
        let label = UILabel()
        label.text = "Photos and videos"
        return label
    }()
    
    let ratingsLabel: UILabel = {
        let label = UILabel()
        label.text = "9.26M"
        label.textColor = .systemPink
        
        return label
    }()
    
    func createScreenShotImageView() -> UIImageView {
        let imageView = UIImageView()
        return imageView
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

fileprivate extension SearchResultsCell {
    func setupCell() {
        ratingsLabel.textColor = .systemPurple
        nameLabel.font = UIFont(name: "Avenir-Heavy", size: 20)
        ratingsLabel.font = UIFont(name: "Avenir-Heavy", size: 20)
        releaseDate.font = UIFont(name: "Avenir", size: 20)
        
        //Laying out the cell
        let infoTopStackView = UIStackView(arrangedSubviews: [moviePosterImageView,VerticalStackView(arrangeSubViews: [nameLabel, releaseDate, ratingsLabel])])
        
        infoTopStackView.spacing = 12
        infoTopStackView.alignment = .center
        
        let overallStackView = VerticalStackView(arrangeSubViews: [infoTopStackView], spacing: 16)
        
        addSubview(overallStackView)
        overallStackView.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
    }
}
