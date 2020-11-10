//
//   CastImageModel.swift
//  MovieShelf
//
//  Created by Joseph Bouhanef on 2020-07-21.
//  Copyright © 2020 Joseph Bouhanef. All rights reserved.
//

import Foundation

struct ProfileResults: Decodable {
    
    var profiles: [Profiles]
}

struct Profiles: Decodable {
    var file_path: String?
}
