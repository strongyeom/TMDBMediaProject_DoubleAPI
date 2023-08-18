//
//  MovieCast.swift
//  TMDBMediaProject_DoubleAPI
//
//  Created by 염성필 on 2023/08/18.
//

import Foundation

// MARK: - MovieCast
struct MovieCast: Codable {
    
    static let imageUrl = "https://www.themoviedb.org/t/p/w276_and_h350_face"
    
    let id: Int
    let cast: [Cast]
    
    
}

// MARK: - Cast
struct Cast: Codable {
    
    let name: String
    let profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case profilePath = "profile_path"
    }
    
}
