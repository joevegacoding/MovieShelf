//
//  PreviewMode.swift
//  MovieShelf
//
//  Created by Joseph Bouhanef on 2020-06-28.
//  Copyright © 2020 Joseph Bouhanef. All rights reserved.
//

import Foundation

struct BackdropResult: Decodable {
    let backdrops: [Backdrops]    
}

struct Backdrops: Decodable {
   
    var file_path: String?

}
