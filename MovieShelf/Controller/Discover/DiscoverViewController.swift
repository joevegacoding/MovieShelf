//
//  AppViewController.swift
//  MovieShelf
//
//  Created by Joseph Bouhanef on 2020-06-22.
//  Copyright © 2020 Joseph Bouhanef. All rights reserved.
//

import UIKit

//This is gonna be discover

class DiscoverViewController: BaseListController, UICollectionViewDelegateFlowLayout {
    
    let reuseIdentifierDiscover = "discoverCell"
    let headerId = "headerId"
    
    let loadingIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        aiv.color = .black
        aiv.startAnimating()
        aiv.hidesWhenStopped = true
        return aiv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .systemBackground
        
        navigationItem.title = "Discover"
        collectionView.register(DiscoverResultsCell.self, forCellWithReuseIdentifier: reuseIdentifierDiscover)
        //1
        collectionView.register(MoviePageHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        
        view.addSubview(loadingIndicatorView)
        loadingIndicatorView.fillSuperview()
        
        fetchData()
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let fullController = MoviesHorizontalController(mode: .fullscreen)
        fullController.searchResult = self.groups[indexPath.item]
        present(fullController, animated: true)
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! MoviePageHeader
        
        header.categoryLabel.text = "Science Fiction"
        header.appHeaderHorozzontalController.movieResult = self.movieResult
        header.appHeaderHorozzontalController.collectionView.reloadData()
        
          header.appHeaderHorozzontalController.didSelectHandler = { [weak self] searchResult in
                   let movieDetailsController = MovieDetailsController()
                   movieDetailsController.searchResult = searchResult
                   movieDetailsController.view.backgroundColor = .systemBackground
                   self?.navigationController?.pushViewController(movieDetailsController, animated: true)
        }
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 300)
    }
    
    
    var groups = [SearchResult]()
    var movieResult = [Result]()
    
    fileprivate func fetchData() {
        
        var group1: SearchResult?
        var group2: SearchResult?
        var group3: SearchResult?
        var group4 : SearchResult?
        //sync the data fetches together
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        Service.sharedService.fetchComedy { (searchResults, error) in
            dispatchGroup.leave()
            group1 = searchResults
        }
        
        dispatchGroup.enter()
        Service.sharedService.fetchDiscoverActionAdventure { (searchResults, error) in
            dispatchGroup.leave()
            group2 = searchResults
        }
        dispatchGroup.enter()
        Service.sharedService.fetchScienceFiction { (searchResults, error) in
            dispatchGroup.leave()
            group3 = searchResults
        }
        dispatchGroup.enter()
        Service.sharedService.fetchHorrors { (searchResults, error) in
            dispatchGroup.leave()
            group4 = searchResults
        }
        dispatchGroup.enter()
        Service.sharedService.fetchTrendingMovies { (movies, error) in
            // should chek the error
            dispatchGroup.leave()
            self.movieResult = movies
        }
        
        
        //fire a completion
        dispatchGroup.notify(queue: .main) {
            print("completed")
            
            self.loadingIndicatorView.stopAnimating()
            if let group =  group1 {
                self.groups.append(group)
            }
            if let group =  group2 {
                self.groups.append(group)
            }
            if let group =  group3 {
                self.groups.append(group)
            }
            if let group =  group4 {
                self.groups.append(group)
            }
            self.collectionView.reloadData()
        }
        
    }

    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierDiscover, for: indexPath) as! DiscoverResultsCell
        let discoverGroup = groups[indexPath.item]
        
        if indexPath.item == 0 {
            cell.titleLabel.text = "Comedy"
        } else if indexPath.item == 1 {
            cell.titleLabel.text = "Action & Adventure"
        } else if indexPath.item == 2 {
            cell.titleLabel.text = "Science Fiction"
        } else {
            cell.titleLabel.text = "Horror"
        }
        
        cell.horizontalController.searchResult = discoverGroup
        cell.horizontalController.collectionView.reloadData()
        cell.horizontalController.didSelectHandler = { [ weak self] searchResults in
            
            let movieDetailsController = MovieDetailsController()
            movieDetailsController.searchResult = searchResults
            movieDetailsController.navigationItem.title = searchResults.original_title
            movieDetailsController.navigationItem.largeTitleDisplayMode = .automatic
            self?.navigationController?.pushViewController(movieDetailsController, animated: true)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 0, right: 0)
    }
}

