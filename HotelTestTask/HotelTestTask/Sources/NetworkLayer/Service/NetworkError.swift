//
//  NetworkError.swift
//  HotelTestTask
//
//  Created by Семен Гайдамакин on 04.01.2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL, invalidResponse, noData, jsonParsingFailed
}
