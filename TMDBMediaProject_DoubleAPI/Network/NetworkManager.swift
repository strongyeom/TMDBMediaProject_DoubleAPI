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
                  //  print("\(data)")
                    completionHandler(data)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
   
}
