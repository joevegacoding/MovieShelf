//
//  AppsHorizontalController.swift
//  MovieShelf
//
//  Created by Joseph Bouhanef on 2020-07-03.
//  Copyright © 2020 Joseph Bouhanef. All rights reserved.
//

import UIKit

class HeaderHorizontalController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    var movieResult = [Result]()
    var searchResult: SearchResult?
    
    var didSelectHandler: ((Result) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .systemBackground
        collectionView.register(MovieHeaderCell.self, forCellWithReuseIdentifier: cellId)
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 48, height: view.frame.height)
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieResult.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let movie = movieResult[indexPath.item]
        didSelectHandler?(movie)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 12, bottom: 0, right: 5)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MovieHeaderCell
        
        let app = self.movieResult[indexPath.item]
        cell.movieTitleLabel.text = app.original_title
        cell.descriptionLabel.text = app.overview
        cell.imageView.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w500/\(app.backdrop_path ?? "")" ))
        
        return cell
    }
}
