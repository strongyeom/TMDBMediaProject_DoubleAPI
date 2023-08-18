//
//  Movie.swift
//  TMDBMediaProject_DoubleAPI
//
//  Created by 염성필 on 2023/08/18.
//
import Foundation

// MARK: - Movie
struct Movie: Codable {
    let page: Int
    var results: [MovieResult]
    let totalPages, totalResults: Int
    
    

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct MovieResult: Codable {
    let backdropPath: String
    let id: Int
    let title: String
    let originalLanguage: String
    let overview, posterPath: String
    let genreIDS: [Int]
    let releaseDate: String
    let video: Bool
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id, title
        case originalLanguage = "original_language"
        case overview
        case posterPath = "poster_path"
        case genreIDS = "genre_ids"
        case releaseDate = "release_date"
        case video
        case voteAverage = "vote_average"
    }
}
