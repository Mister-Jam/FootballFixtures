//
//  NetworkConfig.swift
//  FootballFixtures
//
//  Created by King Bileygr on 8/27/21.
//

import Foundation


protocol NetworkLoader {
    func loadRequest<T: Decodable>(path: String, model: T.Type, completion: @escaping ((Result<T, Error>)->Void))
}

protocol ResultHandler {
    associatedtype Model
    func handleUrlRequest(result: Result<Model, Error>)
}
