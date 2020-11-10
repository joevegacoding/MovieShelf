//
//  ApiService.swift
//  MovieShelf
//
//  Created by Joseph Bouhanef on 2020-06-22.
//  Copyright © 2020 Joseph Bouhanef. All rights reserved.
//

import Foundation

class Service {
    
    static let sharedService = Service() //Singleton object
    
    func fetchMovieSearch(searchTerm: String, completion: @escaping (SearchResult?, Error?) -> ()) {
        
        let urlString = "https://api.themoviedb.org/3/search/movie?api_key=\(Constants.apiKey)&query=\(searchTerm)"
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
}

extension Service {
    
    func fetchTrendingMovies(completion: @escaping ([Result], Error?) -> ()) {
        
        let urlString = "https://api.themoviedb.org/3/trending/movie/day?api_key=\(Constants.apiKey)"
        guard let url = URL(string: urlString) else { return }
        //fetch the data from the internet
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Failed to fetch movie:", error)
                completion([], nil)
                return
            }
            
            //success
            guard let data = data else { return }
            
            do {
                let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
                completion(searchResult.results, nil)
                
            }catch let jsonError {
                print("Failed to decode JSON: ", jsonError)
                completion([], nil)
            }
            
        }.resume() //fire off the request
    }
    func fetchGenres(completion: @escaping ([Genres], Error?) -> ()) {
        
        let urlGenres = "https://api.themoviedb.org/3/genre/movie/list?api_key=\(Constants.apiKey)&language=en-US"
        guard let url = URL(string: urlGenres) else { return }
        
        //fetch the data from the server
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Failed to fetch movie:", error)
                completion([], nil)
                return
            }
            
            //success
            guard let data = data else { return }
            
            do {
                let genreResult = try JSONDecoder().decode(GenreResult.self, from: data)
                completion(genreResult.genres, nil)
                
            }catch let jsonError {
                print("Failed to decode JSON: ", jsonError)
                completion([], nil)
            }
            
        }.resume() //fire off the request
        
    }
    
    func fetchDiscoverActionAdventure(completion: @escaping (SearchResult?, Error?) -> ()) {
        let urlStringDiscover = "https://api.themoviedb.org/3/discover/movie?api_key=\(Constants.apiKey)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=12,28"
        fetcDiscoverGroup(urlStringDiscover: urlStringDiscover, completion: completion)
    }
    
    func fetchComedy(completion: @escaping (SearchResult?, Error?) -> ()) {
        
        fetcDiscoverGroup(urlStringDiscover: "https://api.themoviedb.org/3/discover/movie?api_key=\(Constants.apiKey)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=35", completion: completion)
    }
    
    func fetchScienceFiction(completion: @escaping (SearchResult?, Error?) -> ()) {
        fetcDiscoverGroup(urlStringDiscover: "https://api.themoviedb.org/3/discover/movie?api_key=\(Constants.apiKey)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=878", completion: completion)
    }
    
    func fetchHorrors(completion: @escaping (SearchResult?, Error?) -> ()) {
        
        fetcDiscoverGroup(urlStringDiscover: "https://api.themoviedb.org/3/discover/movie?api_key=\(Constants.apiKey)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=27", completion: completion)
    }
    
    //helper
    func fetcDiscoverGroup(urlStringDiscover: String, completion: @escaping (SearchResult?, Error?) -> Void) {
        
        guard let url = URL(string: urlStringDiscover) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                completion(nil, err)
                return
            }
            do {
                let searchResults = try JSONDecoder().decode(SearchResult.self, from: data!)
                // success
                completion(searchResults, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
    
    //declare my generic json here
    func fetchGenericJSONData<T: Decodable>(urlString: String, completion: @escaping (T?, Error?) -> ()) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                completion(nil, err)
                return
            }
            do {
                let movies = try JSONDecoder().decode(T.self, from: data!)
                // success
                completion(movies, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
}

//declare a tyoe later on. The 'T'(it can be called whatever you want) represnts a placeholder that will be used later on.

class Stack<T: Decodable> {
    var items = [T]()
    func push(item: T) { items.append(item)}
    func pop() ->T? { items.last }
}

import UIKit
func dummyFunc() {
    let stackOfStrings = Stack<String>()
    stackOfStrings.push(item: "it has to be string")
    
    let stackOfInts  = Stack<Int>()
    stackOfInts.push(item: 1)
}

