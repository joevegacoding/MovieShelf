//
//  Person.swift
//  MovieShelf
//
//  Created by Joseph Bouhanef on 2020-07-11.
//  Copyright © 2020 Joseph Bouhanef. All rights reserved.
//

import Foundation

struct Person: Decodable {
    
    var birthday: String?
    var known_for_department: String?
    var biography: String?
    var place_of_birth: String?
    var profile_path: String?
    var name: String
}
