//
//  Coordinator.swift
//  HotelTestTask
//
//  Created by Семен Гайдамакин on 15.12.2023.
//

import Foundation
import UIKit

protocol Coordinator : AnyObject {
    var childControllers : [Coordinator] { get set }
    var parentCoordinator : Coordinator? { get set }
    var navigationController : UINavigationController { get set }
    
    func start()
    func navigateTo(controller: Controllers)
}

extension Coordinator {
    func dismiss() {
        navigationController.popViewController(animated: true)
    }
}

