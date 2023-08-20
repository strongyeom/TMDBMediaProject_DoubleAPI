//
//  MovieVideo.swift
//  TMDBMediaProject_DoubleAPI
//
//  Created by 염성필 on 2023/08/19.
//

import Foundation

// MARK: - MovieVideo
struct MovieVideo: Codable {
    let id: Int
    let results: [Result]
    
}

// MARK: - Result
struct Result: Codable {
    let name, key: String
}
