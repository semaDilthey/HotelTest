//
//  BaseViewModel.swift
//  HotelTestTask
//
//  Created by Семен Гайдамакин on 08.01.2024.
//

import Foundation

//MARK:  Обобщаем все методы, которые будут иметь наши вью модели
protocol BaseViewModelProtocol : AnyObject {
    
    var coordinator : Coordinator? { get set }
    
}

public class BaseViewModel : BaseViewModelProtocol {
    
    var networking : Networking = NetworkManager()
    weak var coordinator: Coordinator?
    
    init(coordinator: Coordinator?) {
        self.coordinator = coordinator
    }
}
