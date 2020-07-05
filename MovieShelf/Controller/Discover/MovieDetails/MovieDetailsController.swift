//
//  MovieDetailsController.swift
//  MovieShelf
//
//  Created by Joseph Bouhanef on 2020-06-24.
//  Copyright © 2020 Joseph Bouhanef. All rights reserved.
//

import UIKit

class MovieDetailsController: BaseListControllerMovieDetail, UICollectionViewDelegateFlowLayout {
    
    var searchResult: Result!
    fileprivate let detailCellId = "detailCellId"
    fileprivate let castReuseIdentifier = "castResultcell"
    fileprivate let previewCellId = "previewCellId"
    fileprivate let headerId = "headerId"
    
    fileprivate var genreArray = [Genres]()
    fileprivate var castArray = [Cast]()
    
    
    
    override func viewDidLoad() {
        //changes the status bar to white
        navigationController?.navigationBar.barStyle = .black
        setup()
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! HeaderCell
        
        header.heavyLabel.text = searchResult.original_title
        header.imageView.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w500/\(searchResult.backdrop_path ?? "")" ))
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 180)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: detailCellId, for: indexPath) as! MovieDetailsCell
            cell.moviePosterImageView.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w500/\(searchResult.poster_path ?? "")" ))
            
            if let voteAverage = searchResult.vote_average {
                cell.ratingLabel.text = String(format: "%.2f/10 ⭐️", voteAverage)
            } else if searchResult.vote_average == 0 {
                cell.ratingLabel.text = "N/A"
            }
            
            cell.releaseDateLabel.text = String(searchResult.release_date ?? "")
            cell.descriptionTextLabel.text = searchResult.overview
            cell.genreLabel.text = genreNameInStringForm(genreIdArray: searchResult.genre_ids)
            
            return cell
        } else if indexPath.item == 1 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: castReuseIdentifier, for: indexPath) as! CastCell
            
            cell.horizontalController.didSelectHandler = { [weak self] cast in
                let redcontroller = UIViewController()
                redcontroller.view.backgroundColor = .red
                redcontroller.navigationItem.title = cast.character
                self?.navigationController?.pushViewController(redcontroller, animated: true)
            }
            return cell.getSearchRequest(searchResult: searchResult)
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: previewCellId, for: indexPath) as! PreviewCell
            return cell.getSearchRequest(searchResult: searchResult)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //var height: CGFloat = 280
        if indexPath.item == 0 {
            
            //calculate the necesary size somehow
            let dummyCell = MovieDetailsCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 2000))
            dummyCell.titleLabel.text = searchResult.original_title
            dummyCell.releaseDateLabel.text = searchResult.release_date
            if let voteAverage = searchResult.vote_average {
                dummyCell.ratingLabel.text = String(format: "%.2f", voteAverage)
            }
            dummyCell.castLabel.text =  "Description"
            dummyCell.descriptionTextLabel.text = searchResult.overview
            dummyCell.layoutIfNeeded()
            let estimatedSize = dummyCell.systemLayoutSizeFitting(.init(width: view.frame.width, height: 1000))
            // height = estimatedSize.height
            return .init(width: view.frame.width, height: estimatedSize.height)
        } else if indexPath.item == 1 {
            return .init(width: view.frame.width, height: 310)
        } else {
            let dummyCell = PreviewCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
            dummyCell.sectionTitle.text =  "Images"
            
            return .init(width: view.frame.width, height: 295)
        }
    }
}

fileprivate extension MovieDetailsController {
    
    func setupCollectionView() {
        collectionView.backgroundColor = .systemBackground
        collectionView.register(MovieDetailsCell.self, forCellWithReuseIdentifier: detailCellId)
        collectionView.register(CastCell.self, forCellWithReuseIdentifier: castReuseIdentifier)
        collectionView.register(PreviewCell.self, forCellWithReuseIdentifier: previewCellId)
        collectionView.register(HeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView.contentInsetAdjustmentBehavior = .always
        navigationItem.title = ""
        
    }
    
    func setUpCollectionViewLayout(_ padding: CGFloat) {
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            
            layout.sectionInset = .init(top: padding, left: padding, bottom: padding, right: padding)
        }
    }
    
    
    func setup() {
        super.viewDidLoad()
        setupCollectionView()
        navigationItem.largeTitleDisplayMode = .automatic
        
        //layout customization
        let padding: CGFloat = 10
        setUpCollectionViewLayout(padding)
        getData()
    }
    
    
    func getData() {
        
        let urlString = "https://api.themoviedb.org/3/movie/\(searchResult.id)/credits?api_key=6c585d930b6b55e72e3e31c6506a6ee4"
        Service.sharedService.fetchGenericJSONData(urlString:urlString) { [weak self](result: CastResult?, error) in
            
            guard let theSelf = self else { return }
            guard let castResult = result else { return }
            
            theSelf.castArray = castResult.cast
            
            Service.sharedService.fetchGenres {[weak self] (array, error) in
                guard let theSelf = self else { return }
                
                theSelf.genreArray =  array
            }
            
            DispatchQueue.main.async {
                theSelf.collectionView.reloadData()
            }
        }
    }
    
    func genreNameInStringForm(genreIdArray: Array<Int>?) -> String? {
        guard let array = genreIdArray else { return "" }
        
        var genreNameArray = [String]()
        
        for genre in genreArray {
            if array.contains(genre.id) {
                genreNameArray.append(genre.name)
            }
        }
        
        return genreNameArray.count > 0 ? genreNameArray.joined(separator: ", ") : ""
    }
}
