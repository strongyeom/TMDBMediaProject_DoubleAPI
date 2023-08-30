//
//  NetworkManager.swift
//  TMDBMediaProject_DoubleAPI
//
//  Created by 염성필 on 2023/08/18.
//

import Foundation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() { }
    
    
    
    func callRequstUnsplash(searchText: String, page: Int, completionHandler: @escaping (Unsplash?) -> Void) {
        
        let url = URL(string: "https://api.unsplash.com/search/photos?query=\(searchText)&page=\(page)&per_page=20&client_id=\(APIKey.unsplashKey)")!
        
        AF.request(url, method: .get).validate()
            .responseDecodable(of: Unsplash.self) { response in
                switch response.result {
                case .success(let data):
                    print("성공")
                    completionHandler(data)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func callRequest(page:Int, completionHandler: @escaping (Movie?) -> Void) {
        
       // let url = "https://api.themoviedb.org/3/trending/movie/week?language=ko-KR"
        
        var components = URLComponents(string: "https://api.themoviedb.org/3/trending/movie/week?")!
        let language = URLQueryItem(name: "language", value: "ko-KR")
        let page = URLQueryItem(name: "page", value: "\(page)")
        components.queryItems = [language, page]
        let url = components.url!

        print("url",url)

        let header: HTTPHeaders = [
            "Authorization": APIKey.tmdbAccessToken,
            "accept": "application/json"
        ]
        
        
        AF.request(url, headers: header).validate(statusCode: 200...500)
            .responseDecodable(of: Movie.self) { response in
                switch response.result {
                case .success(let data):
                    // print("데이터 통신 완료 :,\(data)")
                    completionHandler(data)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func callRequestCast(id: Int, success: @escaping (MovieCast?, MovieVideo?) -> Void, failure: @escaping () -> Void) {
        
        var components = URLComponents(string: "https://api.themoviedb.org/3/movie/\(id)/credits?")!
        let language = URLQueryItem(name: "language", value: "ko-KR")
        components.queryItems = [language]
        let url = components.url!

        let header: HTTPHeaders = [
            "Authorization": APIKey.tmdbAccessToken,
            "accept": "application/json"
        ]
        
        var videocomponents = URLComponents(string: "https://api.themoviedb.org/3/movie/\(id)/videos?")!
        let videolanguage = URLQueryItem(name: "language", value: "ko-KR")
        videocomponents.queryItems = [language]
        let videourl = videocomponents.url!

        
        // cast API통신
        AF.request(url, headers: header).validate(statusCode: 200...500)
            .responseDecodable(of: MovieCast.self) { response in
                switch response.result {
                case .success(let data):
                        print("\(data)")
                    // video API 통신
                    AF.request(videourl, headers:  header).validate(statusCode: 200...500)
                        .responseDecodable(of: MovieVideo.self) { response in
                            switch response.result {
                            case .success(let videoData):
                                success(data,videoData)
                            case .failure(let error):
                                print(error)
                                failure()
                            }
                        }
                case .failure(let error):
                    print(error)
                    failure()
                }
            }

    }
    
    
        // 비디오 베이스 URL https://www.youtube.com/watch?v=(key)
    func callRequestVideo(id: Int, completionHandler: @escaping (MovieVideo?) -> Void) {

        var components = URLComponents(string: "https://api.themoviedb.org/3/movie/\(id)/videos?")!
        let language = URLQueryItem(name: "language", value: "ko-KR")
        components.queryItems = [language]
        let url = components.url!

        let header: HTTPHeaders = [
            "Authorization": APIKey.tmdbAccessToken,
            "accept": "application/json"
        ]

        AF.request(url, headers: header).validate(statusCode: 200...500)
            .responseDecodable(of: MovieVideo.self) { response in
                switch response.result {
                case .success(let data):
                    completionHandler(data)
                case .failure(let error):
                    print(error)
                }
            }
    }
   
}
