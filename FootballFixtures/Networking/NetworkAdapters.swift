//
//  NetworkAdapters.swift
//  FootballFixtures
//
//  Created by King Bileygr on 8/28/21.
//

import Foundation

struct NetworkAdapter: NetworkLoader {

    
    var networkService: NetworkManager
    
    func loadRequest<T>(path: String, model: T.Type, completion: @escaping ((Result<T, Error>) -> Void)) where T : Decodable {
        networkService.loadRequest(path: path, model: model) { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
    
}
