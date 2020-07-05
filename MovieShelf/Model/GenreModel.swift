//
//  GenreModel.swift
//  MovieShelf
//
//  Created by Joseph Bouhanef on 2020-06-24.
//  Copyright © 2020 Joseph Bouhanef. All rights reserved.
//

import Foundation

struct GenreResult: Decodable {
     let genres: [Genres]
}

struct Genres: Decodable {
    let name: String
    let id: Int
  
}
