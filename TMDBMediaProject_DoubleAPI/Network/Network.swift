//
//  Network.swift
//  TMDBMediaProject_DoubleAPI
//
//  Created by 염성필 on 2023/09/19.
//

import Foundation
import Alamofire

class Network {
    static let shared = Network()
    
    private init() { }
    
    func reqeust<T:Codable>(type: T.Type, api: TMDBAPI, completionHandler: @escaping((Result<T, TMDBError>) -> Void)) {
        
        
        AF.request(api.endPoint, parameters: api.query, encoding: URLEncoding(destination: .queryString),headers: api.header).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                completionHandler(.success(data))
            case .failure(_):
                guard let status = response.response?.statusCode else { return }
                guard let error = TMDBError(rawValue: status) else { return }
                completionHandler(.failure(error))
            }
        }
    }
}
