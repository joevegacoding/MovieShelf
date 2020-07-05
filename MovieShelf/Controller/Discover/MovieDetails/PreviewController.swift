//
//  VideoPreviewController.swift
//  MovieShelf
//
//  Created by Joseph Bouhanef on 2020-06-27.
//  Copyright © 2020 Joseph Bouhanef. All rights reserved.
//

import UIKit

class PreviewController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout{
    
    var searchResult: Result!
    fileprivate var backdropArray = [Backdrops]()
    let cellId = "cellId"
    
    class ScreenshotCell: UICollectionViewCell {
        
        let imageView = UIImageView(cornerRadius: 12)
        
        override init(frame: CGRect) {
            super.init(frame: frame)
         
            imageView.backgroundColor = .systemPurple
            addSubview(imageView)
            imageView.fillSuperview()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        collectionView.register(ScreenshotCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.contentInset = .init(top: 35, left: 0, bottom: 40, right: 5)
        collectionView.backgroundColor = .systemBackground
    }
    
    func getSetup() {
        setup()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 350, height: view.frame.height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return backdropArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ScreenshotCell
        
        let backdrop = backdropArray[indexPath.item]
        cell.imageView.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w500/\(backdrop.file_path ?? "")" ))
        return cell
    }
}

fileprivate extension PreviewController {
    
    func setup() {
        getData()
    }
    
    func getData() {
        
        let urlString = "https://api.themoviedb.org/3/movie/\(searchResult.id)/images?api_key=6c585d930b6b55e72e3e31c6506a6ee4"
        
        Service.sharedService.fetchGenericJSONData(urlString: urlString) { [weak self](result: BackdropResult?, error) in
            
            guard let theSelf = self else { return }
            guard let backdropResult = result else { return }
            
            theSelf.backdropArray = backdropResult.backdrops
            DispatchQueue.main.async {
                theSelf.collectionView.reloadData()
            }
        }
    }    
}

