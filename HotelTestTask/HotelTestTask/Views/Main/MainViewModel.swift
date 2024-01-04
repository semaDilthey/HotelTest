//
//  MainViewModel.swift
//  HotelTestTask
//
//  Created by Семен Гайдамакин on 15.12.2023.
//

import Foundation

protocol MainViewModelProtocol {
    var networking : Networking { get }
    
    func getHotel(completion: @escaping () -> Void)
    func getRooms() -> [Room]

}

class MainViewModel {
    
    var networking : Networking = NetworkManager()
    var coordinagor = Coordinator()

    var hotels : [Hotel]? = []
    
    func getHotel(completion: @escaping () -> Void){
        networking.getHotel { [weak self] data in
            switch data {
            case .success(let hotel):
                self?.hotels?.append(hotel)
            case .failure(let fail):
                print(fail)
            }
            completion()
        }
    }
    
    func getRooms() -> [Room] {
        var rooms : [Room] = []
        let semaphore = DispatchSemaphore(value: 0)
        networking.getRooms { [weak self] data in
            switch data {
            case .success(let room):
                rooms.append(contentsOf: room.rooms)
            case .failure(let error):
                print("Error with fetching rooms \(error.localizedDescription)")
            }
            semaphore.signal()
        }
        semaphore.wait()
        return rooms
    }
    
    // Возвращает комнаты для данного отеля по id.
    // Аки заглушка
    func getRooms(id : Int, rooms: [Room]) -> [Room] {
        var roomsDatabase: [Int?: [Room]] = [:]
        if id == 1 {
            roomsDatabase = [id: rooms]
        }
            return roomsDatabase[id] ?? []
        }
}
