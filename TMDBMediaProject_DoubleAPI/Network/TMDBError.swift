//
//  UnsplashError.swift
//  TMDBMediaProject_DoubleAPI
//
//  Created by 염성필 on 2023/09/19.
//

import Foundation

enum TMDBError: Int, Error, LocalizedError {
    case unAuthentication = 401
    case InvalidFormat = 405
    case InvalidParameters = 422
    
    var description: String {
        switch self {
        case .unAuthentication:
            return "권한이 없습니다."
        case .InvalidFormat:
            return "형식이 존재 하지 않는다."
        case .InvalidParameters:
            return "검색어가 존재하지 않습니다."
        }
    }
}
