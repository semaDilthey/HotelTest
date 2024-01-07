//
//  RoomViewModel.swift
//  HotelTestTask
//
//  Created by Семен Гайдамакин on 15.12.2023.
//

import Foundation
import UIKit

final class RoomViewModel : BaseViewModel {
    
    init(data: [Room]? = nil, coordinator : Coordinator?) {
        self.rooms = data
        super.init(coordinator: coordinator)
    }
    
    var rooms : [Room]? = [] {
        didSet {
            reloadTableView?()
        }
    }
    
    var reloadTableView: (() -> Void)?

    func getRoomModel(at indexPath: IndexPath) -> RoomCellModelProtocol? {
        guard let rooms, indexPath.row < rooms.count else {
                return nil
            }
        let room = rooms[indexPath.row]
        return createCellModel(from: room)
    }

    private func createCellModel(from room: Room) -> RoomCellModelProtocol {
        return RoomCellModel(id: room.id, name: room.name, peculiarities: room.peculiarities, price: String(room.price), pricePer: room.pricePer, imagesUrls: room.imageUrls)
    }
    
}
