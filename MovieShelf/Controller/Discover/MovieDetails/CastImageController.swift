//
//  CastImageController.swift
//  MovieShelf
//
//  Created by Joseph Bouhanef on 2020-11-10.
//  Copyright © 2020 Joseph Bouhanef. All rights reserved.
//

import UIKit

class CastImageController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout {
    var castResult: Cast!
    var profilesArray = [Profiles]()
    var didSelectHandler:  ((_ profileSelected: Profiles, _ allProfiles: Array<Profiles>) -> ())?
    
    class HorizontalImageCastCell: UICollectionViewCell {
        let imageView = UIImageView(cornerRadius: 12)

        override init(frame: CGRect) {
            super.init(frame: frame)
            imageView.backgroundColor = .systemPink
            
            backgroundColor = .systemBackground
            addSubview(imageView)
            imageView.fillSuperview()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(HorizontalImageCastCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.backgroundColor = .systemBackground
        collectionView.contentInset = .init(top: 5, left: 10, bottom: 35, right: 10)
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    func getSetup() {
        setup()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let castImage = profilesArray[indexPath.item]
            didSelectHandler?(castImage, profilesArray)
    }
        
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return profilesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 180, height: 300)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HorizontalImageCastCell
        let profiles = profilesArray[indexPath.item]
        cell.imageView.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w500/\(profiles.file_path ?? "")" ))
        cell.backgroundColor = .systemBackground
        return cell
    }
}

fileprivate extension CastImageController {
    
    func setup() {
        getData()
    }
    
    func getData() {
        
        let urlString = "https://api.themoviedb.org/3/person/\(castResult.id)/images?api_key=\(Constants.apiKey)"
        
        Service.sharedService.fetchGenericJSONData(urlString: urlString) { [weak self](result: ProfileResults?, error) in
            
            guard let theSelf = self else { return }
            guard let castResult = result else { return }
            
            theSelf.profilesArray = castResult.profiles
            DispatchQueue.main.async {
                theSelf.collectionView.reloadData()
            }
        }
    }
}

