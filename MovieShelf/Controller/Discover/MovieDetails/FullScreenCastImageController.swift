//
//  FullScreenCastImageController.swift
//  MovieShelf
//
//  Created by Joseph Bouhanef on 2020-07-30.
//  Copyright © 2020 Joseph Bouhanef. All rights reserved.
//

import UIKit

class FullScreenCastImageController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout {
    
    var actorImageResult: Profiles!
    var profilesArray = [Profiles]()
    
    let fullImageid = "fullImageid"

    override func viewDidLoad() {
        super.viewDidLoad()
       
        collectionView.isUserInteractionEnabled = true
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(FullScreenCastImageController.toggle))
                view.isUserInteractionEnabled = true
                view.addGestureRecognizer(gesture)

       collectionView.backgroundColor = .systemBackground
        
        collectionView.register(FullScreenCastImageCell.self, forCellWithReuseIdentifier: fullImageid)
        collectionView.contentInset = .init(top: 0, left: 0, bottom: 0, right: 10)
        navigationItem.largeTitleDisplayMode = .never
    }
    
    @objc func toggle() {
        //self.tabBarController?.tabBar.isHidden = true
           navigationController?.setNavigationBarHidden(navigationController?.isNavigationBarHidden == false, animated: true)
        self.tabBarController?.tabBar.isHidden = false
        
       }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return profilesArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: fullImageid, for: indexPath) as! FullScreenCastImageCell
        let profiles = profilesArray[indexPath.item]
        cell.actorFullScreenImageView.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w500/\(profiles.file_path ?? "")" ))
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: view.frame.height)
    }
}
