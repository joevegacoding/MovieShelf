//
//  AppsPageHeader.swift
//  MovieShelf
//
//  Created by Joseph Bouhanef on 2020-07-03.
//  Copyright © 2020 Joseph Bouhanef. All rights reserved.
//

import UIKit

class  MoviePageHeader: UICollectionReusableView {
    var categoryLabel = UILabel(text: "Trending", font: .boldSystemFont(ofSize: 30))

    
    let appHeaderHorozzontalController = HeaderHorizontalController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        categoryLabel.textColor = .systemBlue
 
        addSubview(appHeaderHorozzontalController.view)
        appHeaderHorozzontalController.view.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
