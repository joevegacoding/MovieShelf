//
//  VerticalStackView.swift
//  MovieShelf
//
//  Created by Joseph Bouhanef on 2020-06-22.
//  Copyright © 2020 Joseph Bouhanef. All rights reserved.
//

import UIKit

class VerticalStackView: UIStackView {
    init(arrangeSubViews: [UIView], spacing: CGFloat = 0) {
        super.init(frame: .zero)
        
        arrangeSubViews.forEach ({addArrangedSubview($0)})
        
        self.spacing = spacing
        self.axis = .vertical
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
