//
//  RoomViewModel.swift
//  HotelTestTask
//
//  Created by Семен Гайдамакин on 15.12.2023.
//

import Foundation
import UIKit

protocol RoomViewModelProtocol {
    
}

class RoomViewModel {
    
    let networking : Networking = NetworkManager()
    let coordinator = Coordinator()
    
    var rooms : [Room]? = [] {
        didSet {
            reloadTableView?()
        }
    }
    
    init(data: [Room]? = nil) {
        self.rooms = data
    }
    
    var reloadTableView: (() -> Void)?
    
    private func createCellModel(from room: Room) -> RoomCellModelProtocol {
        return RoomCellModel(id: room.id, name: room.name, peculiarities: room.peculiarities, price: String(room.price), pricePer: room.pricePer, imagesUrls: room.imageUrls)
    }
    
    func getRoomModel(at indexPath: IndexPath) -> RoomCellModelProtocol? {
        guard let rooms, indexPath.row < rooms.count else {
                return nil
            }
        let room = rooms[indexPath.row]
        return createCellModel(from: room)
    }
    
    
    func openBooking(with id: Int, navController: UINavigationController?) {
        let bookingViewModel = BookingViewModel(roomId: id)
        let bokkingVC = BookingViewController(viewModel: bookingViewModel)
        guard let navController else { return }
        navController.pushViewController(bokkingVC, animated: true)
    }
}
