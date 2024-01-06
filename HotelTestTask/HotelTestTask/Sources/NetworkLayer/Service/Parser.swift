//
//  Parser.swift
//  HotelTestTask
//
//  Created by Семен Гайдамакин on 15.12.2023.
//

import Foundation

class Parser {
    
    public func decodeJSON <T: Decodable>(ofType: T.Type, from data: Data?, completion: @escaping (Result<T, Error>) -> Void) {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        guard let data else {
            completion(.failure(NetworkError.noData))
            return
        }
        
        if let parsedData = try? decoder.decode(ofType.self, from: data) {
            completion(.success(parsedData))
        } else {
            completion(.failure(NetworkError.jsonParsingFailed))
        }
        
    }
    
}
