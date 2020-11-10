//
//  CasrDetailsController.swift
//  MovieShelf
//
//  Created by Joseph Bouhanef on 2020-07-11.
//  Copyright © 2020 Joseph Bouhanef. All rights reserved.
//

import UIKit

class CastDetailsController: BaseListController, UICollectionViewDelegateFlowLayout {
    
    var searchResult: Result!
    var personResult: Person!
    
    var castResult: Cast!
    let cellId = "cellId"
    let imageCellId = "imageCellId"
    fileprivate var castArray = [Person]()
    
    override func viewDidLoad() {
        
    }
    
    override var prefersStatusBarHidden: Bool {
            return navigationController?.isNavigationBarHidden == true
        }
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
            return UIStatusBarAnimation.slide
        }
    
    func setup() {
        super.viewDidLoad()
        setpCollectionViews()
        getData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CastPageCell
            cell.personResult = personResult
            return cell
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imageCellId, for: indexPath) as! ImageCastCell
            cell.horizontalController.didSelectHandler = { [weak self] profile, allprofiles in
                
                let fullImageController = FullScreenCastImageController()
                fullImageController.view.backgroundColor = .systemBackground
                fullImageController.actorImageResult = profile
                fullImageController.profilesArray = allprofiles
                self?.navigationController?.pushViewController(fullImageController, animated: true)
            }
            return cell.getSearchRequest(castResult: castResult)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.item == 0 {
            //calculate tghe necessary cell somehow
            let dummyCell = CastPageCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 1000))
            dummyCell.personResult = personResult
            dummyCell.layoutIfNeeded()
            
            let estimatedSize = dummyCell.systemLayoutSizeFitting(.init(width: view.frame.width, height: 1000))
            
            return .init(width: view.frame.width, height: estimatedSize.height)
        } else {
            let castImageCell = ImageCastCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
            castImageCell.sectionTitle.text =  "Images"
            castImageCell.backgroundColor = .systemBackground

            
            return .init(width: view.frame.width, height: 340)
        }
    }
}

fileprivate extension CastDetailsController {
    
    func getData() {
        
        let urlString = "https://api.themoviedb.org/3/person/\(castResult.id)?api_key=\(Constants.apiKey)&language=en-US"
        
        Service.sharedService.fetchGenericJSONData(urlString:urlString) { [weak self](result: Person?, error) in
            
            guard let theSelf = self else { return }
            guard let personResult = result else { return }
            
            theSelf.personResult = personResult
            DispatchQueue.main.async {
                theSelf.collectionView.reloadData()
            }
        }
    }
    
    func setpCollectionViews() {
        
        collectionView.backgroundColor = .systemBackground
        collectionView.register(CastPageCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(ImageCastCell.self, forCellWithReuseIdentifier: imageCellId)
    }
}
