//
//  TMDBAPI.swift
//  TMDBMediaProject_DoubleAPI
//
//  Created by 염성필 on 2023/09/19.
//

import Foundation
import Alamofire

enum TMDBAPI {
    case all(page: Int) // https://api.themoviedb.org/3/trending/movie/week?language=ko-KR
    case cast(id: Int) // https://api.themoviedb.org/3/movie/(id)/credits?language=ko-KR
    case video(id: Int) // https://api.themoviedb.org/3/movie/(id)/videos?language=ko-KR
    
    var baseURL: String {
        
        switch self {
        case .all:
            return "https://api.themoviedb.org/3/"
        case .cast, .video:
            return "https://api.themoviedb.org/3/movie/"
        }
        
        
    }

    var query: [String: String] {
        switch self {
        case .all(let page):
            return ["language":"ko-KR", "page": "\(page)"]
        case .cast, .video:
            return ["language":"ko-KR"]
        }
       
    }
    
    var header: HTTPHeaders {
        return ["Authorization": APIKey.tmdbAccessToken,
                "accept": "application/json"]
    }
    
    var endPoint: URL {
        switch self {
        case .all:
            return URL(string: baseURL + "trending/movie/week")!
        case .cast(let id):
            return URL(string: baseURL + "\(id)/credits")!
        case .video(let id):
            return URL(string: baseURL + "\(id)/videos")!
        }
    }
    
    
}
