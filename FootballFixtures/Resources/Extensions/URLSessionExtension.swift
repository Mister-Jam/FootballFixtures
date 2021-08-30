//
//  URLSessionExtension.swift
//  FootballFixtures
//
//  Created by King Bileygr on 8/27/21.
//

import Foundation


extension URLSession {
        //MARK: Get Data From a URL Session
        //MARK: Decode Data Gotten From a URL Session
        func decodeData<T: Decodable> (from url: URLRequest, type: T.Type,
                                       keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy     = .useDefaultKeys,
                                       dataDecodingStrategy: JSONDecoder.DataDecodingStrategy   = .deferredToData,
                                       completion: @escaping ((Result<T, Error>)->Void)
        ) {
            
            URLSession.shared.dataTask(with: url) { apiData, _, apiError in
                guard let apiData = apiData, apiError == nil else {
                    completion(.failure(apiError!))
                    return }
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy     = keyDecodingStrategy
                decoder.dataDecodingStrategy    = dataDecodingStrategy
                do {
                    let decodedData = try decoder.decode(T.self, from: apiData)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(error))
                }
            }.resume()
        }
        
        enum DecodingErrors: String, Error {
            case failedToFetchData = "Unable to fetch data from the web....Check your network and try again"
            case failedToDecode = "Lack of permission to view resource so error message was sent"
        }
        
    }
