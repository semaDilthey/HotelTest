//
//  Coordinator.swift
//  HotelTestTask
//
//  Created by Семен Гайдамакин on 15.12.2023.
//

import Foundation
import UIKit

protocol CoordinatorProtocol: AnyObject {
    func start(window: UIWindow)
//    func showwMainVC(controller: UINavigationController)
//    func showErrorController(controller: UINavigationController)
//    func showDetailsController(controller: UINavigationController, dataStorage: DataStorageProtocol)
    
}
class Coordinator: CoordinatorProtocol {
    
    func start(window: UIWindow)  {
        let viewModel = MainViewModel()

        let vc = MainViewController(viewModel: viewModel)
        let navController = UINavigationController(rootViewController: vc)
        window.rootViewController = navController
        window.makeKeyAndVisible()
    }
    
    func mockStart(window: UIWindow) {
//        let viewModel = BookingViewModel(roomId: 1)
//
//        let vc = BookingViewController(viewModel: viewModel)
        let vc = PaidViewController()
        let navController = UINavigationController(rootViewController: vc)
        window.rootViewController = navController
        window.makeKeyAndVisible()
    }
    
    func showwRoomsViewController(controller: UINavigationController, data: [Room]?, hotelName : String) {
        let viewModel = RoomViewModel(data: data)
        let vc = RoomsViewController(viewModel: viewModel)
        vc.navigationItem.title = hotelName
        controller.pushViewController(vc, animated: true)
//        setViewController(controller: controller, with: [vc])
    }
    
    func showBookingController(controller: UINavigationController) {
        let viewModel = BookingViewModel(roomId: 1)
        let vc = BookingViewController(viewModel: viewModel)
        setViewController(controller: controller, with: [vc])
    }
    
    func showPaidController(controller: UINavigationController?) {
        guard let controller else { return }
        let vc = PaidViewController()
        setViewController(controller: controller, with: [vc])
    }
    
    private func setViewController(controller: UINavigationController, with viewControllers: [UIViewController], animated: Bool = true) {
        var vcArray = controller.viewControllers
        vcArray.removeAll()
        vcArray.append(contentsOf: viewControllers)

        controller.setViewControllers(vcArray, animated: animated)
    }

}
