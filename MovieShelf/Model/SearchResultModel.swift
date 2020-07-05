//
//  SearchResultModel.swift
//  MovieShelf
//
//  Created by Joseph Bouhanef on 2020-06-22.
//  Copyright © 2020 Joseph Bouhanef. All rights reserved.
//

import Foundation


struct SearchResult: Decodable {
    let results: [Result]
    
}

struct Result: Decodable {
    let original_title: String?
    let release_date: String?
    var poster_path: String?
    var backdrop_path: String?
    let genre_ids: [Int]?
    let vote_average: Double?
    var id: Int
    let overview: String?
}
