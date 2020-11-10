//
//  VideosModel.swift
//  MovieShelf
//
//  Created by Joseph Bouhanef on 2020-07-11.
//  Copyright © 2020 Joseph Bouhanef. All rights reserved.
//

import Foundation

struct VideoResults: Decodable {
    var results: [Results]
    
}

struct Results: Decodable {
    var id: String
    var key: String?
    var type: String?
    var name: String?
}

