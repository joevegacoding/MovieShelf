//
//  CastPageCell.swift
//  MovieShelf
//
//  Created by Joseph Bouhanef on 2020-07-11.
//  Copyright © 2020 Joseph Bouhanef. All rights reserved.
//

import UIKit

class CastPageCell: UICollectionViewCell {
    
    var personResult: Person! {
        didSet {
            profileImageView.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w500/\(personResult?.profile_path ?? "")" ))
            dateOfBirth.text = personResult?.birthday
            placeOfBirth.text = personResult?.place_of_birth
            if personResult?.biography == "" {
                biography.text = "No biography has been setup yet for \(personResult.name)."
            } else {
                biography.text = personResult?.biography
            }
            knowFor.text = personResult?.known_for_department
        }
    }
    
    let profileImageView = UIImageView(cornerRadius: 12)
    //let personName = UILabel(text: "Ben Affleck", font: .systemFont(ofSize: 25))
    let dateOfBirth = UILabel(text: "1983", font: .systemFont(ofSize: 20))
    let biography = UILabel(text: "Ben Affleck ", font: .systemFont(ofSize: 19), numberOfLines: 0)
    let biographyTitle = UILabel(text: "Biography", font: .systemFont(ofSize: 19))
    let placeOfBirth = UILabel(text: "new york", font: .systemFont(ofSize: 17), numberOfLines: 0)
    let bornLabel = UILabel(text: "Born: ", font: .systemFont(ofSize: 20))
    let knownForLabel = UILabel(text: "Department: ", font: .systemFont(ofSize: 20))
    let knowFor = UILabel(text: "Directing", font: .systemFont(ofSize: 20))
    let bottomSectionTitle = UILabel(text: "Images", font: .systemFont(ofSize: 25))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpElementAttributes()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

fileprivate extension CastPageCell {
    
    func setUpElementAttributes() {
        profileImageView.backgroundColor = .systemPurple
        profileImageView.constrainWidth(constant: 150)
        profileImageView.constrainHeight(constant: 230)
        //personName.font = UIFont(name: "Avenir-Heavy", size: 25)
        dateOfBirth.font = UIFont(name: "Avenir", size: 17)
        placeOfBirth.font = UIFont(name: "Avenir", size: 17)
        bornLabel.font = UIFont(name: "Avenir-Heavy", size: 20)
        knownForLabel.font = UIFont(name: "Avenir-Heavy", size: 20)
        knowFor.font = UIFont(name: "Avenir", size: 17)
        biographyTitle.font = UIFont(name: "Avenir-Heavy", size: 25)
        biographyTitle.textColor = .systemPurple
        biography.font = UIFont(name: "Avenir", size: 17)
        bottomSectionTitle.font = UIFont(name: "Avenir-Heavy", size: 25)
        bottomSectionTitle.textColor = .systemPurple
        
        let stackView = VerticalStackView(arrangeSubViews: [
            UIStackView(arrangedSubviews: [
                profileImageView,
                VerticalStackView(arrangeSubViews: [
                    bornLabel, dateOfBirth, placeOfBirth, UIStackView(arrangedSubviews: [VerticalStackView(arrangeSubViews: [
                        knownForLabel, knowFor,
                        UIView()
                    ], spacing: 5)], customSpacing: 5),
                    UIView()
                ], spacing: 7)
            ], customSpacing: 20),
            biographyTitle,
            biography, bottomSectionTitle
        ], spacing: 16)
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 20, left: 15, bottom: 20, right: 20))
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 20, left: 20, bottom: 20, right: 20))
    }
}
