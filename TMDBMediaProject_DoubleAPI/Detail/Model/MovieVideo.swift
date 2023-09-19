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
    let results: [MovieFristResult]
    
}

// MARK: - Result
struct MovieFristResult: Codable {
    let name, key: String
}
