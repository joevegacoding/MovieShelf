//
//  CastHorizontalController.swift
//  MovieShelf
//
//  Created by Joseph Bouhanef on 2020-06-25.
//  Copyright © 2020 Joseph Bouhanef. All rights reserved.
//

import UIKit

class CastHorizontalController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout {
    
    var searchResult: Result!
    fileprivate var castArray = [Cast]()
    var didSelectHandler: ((Cast) -> ())?

    let cellId = "cellId"

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectinViews()
    }
    
    func getSetup() {
        setup()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return castArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CastDetailsCell
        
        let cast = castArray[indexPath.item]
        cell.castLabel.text = cast.name
        cell.characterLabel.text = cast.character
        cell.profileImageView.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w500/\(cast.profile_path ?? "")" ))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 180, height: view.frame.height)
    }
}

fileprivate extension CastHorizontalController {
    
    func setupCollectinViews() {
        collectionView.backgroundColor = .systemBackground
        collectionView.register(CastDetailsCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.contentInset = .init(top: 0, left: 12, bottom: 0, right: 12)
    }
    
    func setup() {
        getData()
    }
    
    func getData() {
        
        let urlString = "https://api.themoviedb.org/3/movie/\(searchResult.id)/credits?api_key=6c585d930b6b55e72e3e31c6506a6ee4"
        
        Service.sharedService.fetchGenericJSONData(urlString: urlString) { [weak self](result: CastResult?, error) in
            
            guard let theSelf = self else { return }
            guard let castResult = result else { return }
            
            theSelf.castArray = castResult.cast
            DispatchQueue.main.async {
                theSelf.collectionView.reloadData()
            }
        }
    }
}
