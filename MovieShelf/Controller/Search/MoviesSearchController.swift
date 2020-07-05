//
//  MoviesSearchController.swift
//  MovieShelf
//
//  Created by Joseph Bouhanef on 2020-06-22.
//  Copyright © 2020 Joseph Bouhanef. All rights reserved.
//
import UIKit
import SDWebImage

class MoviesSearchController: BaseListController, UICollectionViewDelegateFlowLayout,
UISearchBarDelegate {
    
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    fileprivate let reuseIdentifier = "resultCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .systemBackground
        collectionView.register(SearchResultsCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        setupSearchBar()
        fetchTrendingMovies()
    }
    
    //Passing data from searchView to MovieDetails when clicked
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieResult = movieResults[indexPath.item]
        let movieDetailsController = MovieDetailsController()
        movieDetailsController.searchResult = movieResult
        movieDetailsController.navigationItem.title = movieResult.original_title
        
        self.navigationController?.pushViewController(movieDetailsController, animated: true)
    }
    
    fileprivate func setupSearchBar() {
        
        definesPresentationContext = true
        navigationItem.searchController = self.searchController
        navigationItem.hidesBackButton = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
    
    var timer: Timer?
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        //This introduces a delay before performing a search. Otherwise, the results appear almost instantly and don't render properly according to the input.
        timer?.invalidate()
        
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { (_) in
            // this will actually fire my search
            Service.sharedService.fetchMovieSearch(searchTerm: searchText) { (results, error) in
                self.movieResults = results?.results ?? []
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    fileprivate var movieResults = [Result]()
    
    fileprivate func fetchTrendingMovies() {
        //inside is the completion being excecuted
        Service.sharedService.fetchTrendingMovies { (results, error) in
            if let error  = error {
                print("failed to fetch movie: " , error )
                return
            }
            
            self.movieResults = results
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    //Will provide the size for each one of the cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 238)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //Returns the number of cells available according to how many data is available
        return movieResults.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SearchResultsCell
        let movieResult =  movieResults[indexPath.item]
        cell.movieResult = movieResult
        
        return cell
    }
}
