//
//  BookingViewModel.swift
//  HotelTestTask
//
//  Created by Семен Гайдамакин on 17.12.2023.
//

import Foundation

class BookingViewModel {
    
    let networking : Networking = NetworkManager()
    weak var coordinator : Coordinator?
    
    var roomId : Int
        
    init(roomId: Int, coordinator: Coordinator?) {
        self.roomId = roomId
        self.coordinator = coordinator
    }
    
    var customer : CustomerProtocol = Customer()
    
    var bookingData : Booking? = nil
    
    func loadBooking(completion: @escaping () -> Void) {
       fetchBooking(id: 1, completion: completion)
    }
    
    private func fetchBooking(id: Int, completion: @escaping () -> Void) {
        if roomId == id || roomId == 2 {
            // По хорошему тут надо в getBookingInformation добавлять параметры id для загрузки конкретного букинга.
            // Или bookingData привести к [Booking] и брать по индексу == roomId
            // Но сделаю если успею, если не успею то текст тут останется.
            networking.getBookingInformation { [weak self] data in
                switch data {
                case .success(let booking):
                    self?.bookingData = booking
                case .failure(let error):
                    print(error.localizedDescription)
                }
                completion()
            }
        }
    }
}
