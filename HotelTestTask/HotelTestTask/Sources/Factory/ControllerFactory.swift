//
//  ControllerFactory.swift
//  HotelTestTask
//
//  Created by Семен Гайдамакин on 05.01.2024.
//

import UIKit

enum Controllers {
    case mainController(viewModel: MainViewModel)
    case roomsController(rooms: [Room]?, hotelName: String)
    case bookingController(roomID: Int)
    case paidController(bookingNumber: Int)
}


protocol ControllerFactory : AnyObject {
    func makeController(controller: Controllers, coordinator: Coordinator) -> UIViewController
}


class AppControllerFactory : ControllerFactory {
    
    func makeController(controller: Controllers, coordinator: Coordinator) -> UIViewController {
        switch controller {
            
        case .mainController(var viewModel):
            viewModel = MainViewModel(coordinator: coordinator)
            return MainViewController(viewModel: viewModel)
            
        case .roomsController(let rooms, let name):
            let viewModel = RoomViewModel(data: rooms, coordinator: coordinator)
            let viewController = RoomsViewController(viewModel: viewModel)
            viewController.navigationItem.title = name
            return viewController
            
        case .bookingController(let roomID):
            let viewModel = BookingViewModel(roomId: roomID, coordinator: coordinator)
            return BookingViewController(viewModel: viewModel)
            
        case .paidController(let bookingNumber):
            let viewModel = PaidViewModel(bookingNumber: bookingNumber, coordinator: coordinator)
            return PaidViewController(viewModel: viewModel)
        }
    }
    
}
