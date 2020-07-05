//
//  Extensions.swift
//  MovieShelf
//
//  Created by Joseph Bouhanef on 2020-06-20.
//  Copyright © 2020 Joseph Bouhanef. All rights reserved.
//



import UIKit

extension UILabel {
    convenience init(text: String, font: UIFont, numberOfLines: Int = 1) {
        self.init(frame: .zero)
        self.text = text
        self.font = font
        self.numberOfLines = numberOfLines
    }
}


extension UIImageView {
    convenience init(cornerRadius: CGFloat) {
        self.init(image: nil)
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds =  true
        self.contentMode = .scaleAspectFill
    }
}
