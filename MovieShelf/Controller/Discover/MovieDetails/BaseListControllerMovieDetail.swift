//
//  BaseListControllerMovieDetail.swift
//  MovieShelf
//
//  Created by Joseph Bouhanef on 2020-06-29.
//  Copyright © 2020 Joseph Bouhanef. All rights reserved.
//

import UIKit

class BaseListControllerMovieDetail: UICollectionViewController {
    
    init() {
        super.init(collectionViewLayout: StretchyHeaderLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

