//
//  Unsplash.swift
//  TMDBMediaProject_DoubleAPI
//
//  Created by 염성필 on 2023/08/30.
//

import UIKit

// MARK: - Unsplash
struct Unsplash: Codable {
    let total, totalPages: Int
    var results: [UnSplashResult]

    enum CodingKeys: String, CodingKey {
        case total
        case totalPages = "total_pages"
        case results
    }
}

// MARK: - Result
struct UnSplashResult: Codable {

    let urls: Urls
    let tags: [Tag]

}


// MARK: - Tag
struct Tag: Codable {
    let title: String
}
// MARK: - Urls
struct Urls: Codable {
    let raw, full, regular, small: String
    let thumb, smallS3: String

    enum CodingKeys: String, CodingKey {
        case raw, full, regular, small, thumb
        case smallS3 = "small_s3"
    }
}

