//
//  NetworkManager.swift
//  FootballFixtures
//
//  Created by King Bileygr on 8/27/21.
//

import Foundation


class NetworkManager: NetworkLoader {
    
    static let shared = NetworkManager()
    
    private init () { }
    
    public func loadRequest<T: Decodable>(path: String, model: T.Type, completion: @escaping ((Result<T, Error>)->Void)) {
        
        guard let url = URL(string: Constants.URLConstants.baseURL+path) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(Constants.URLConstants.apiToken, forHTTPHeaderField: Constants.URLConstants.httpHeader)
        URLSession.shared.decodeData(from: request, type: T.self) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
            
        }
    }
}
