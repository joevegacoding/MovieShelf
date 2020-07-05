//
//  CastModel.swift
//  MovieShelf
//
//  Created by Joseph Bouhanef on 2020-06-24.
//  Copyright © 2020 Joseph Bouhanef. All rights reserved.
//

import Foundation

struct CastResult: Decodable {
    let cast: [Cast]

}

struct Cast: Decodable {
    let cast_id: Int?
    let name: String?
    let character: String?
    var profile_path: String?

}
