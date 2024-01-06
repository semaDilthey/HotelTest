//
//  NetworkManager.swift
//  HotelTestTask
//
//  Created by Семен Гайдамакин on 14.12.2023.
//

import Foundation

protocol Networking: AnyObject {
    func getHotel(completion: @escaping (Result<Hotel, Error>) -> Void)
    func getRooms(completion: @escaping (Result<Rooms, Error>) -> Void)
    func getBookingInformation(completion: @escaping (Result<Booking, Error>) -> Void)
}

class NetworkManager : Networking {
    
    var fetchingService: FetchingServiceProtocol
    
    init(fetchingService: FetchingServiceProtocol = FetchingService()) {
        self.fetchingService = fetchingService
    }
    
    func getHotel(completion: @escaping (Result<Hotel, Error>) -> Void) {
        fetchingService.getData(from: API.hotel, completion: completion)
    }
    
    func getRooms(completion: @escaping (Result<Rooms, Error>) -> Void) {
        fetchingService.getData(from: API.rooms, completion: completion)
    }
    
    func getBookingInformation(completion: @escaping (Result<Booking, Error>) -> Void) {
        fetchingService.getData(from: API.booking, completion: completion)
    }
    
    
}
