//
//  TouristModel.swift
//  HotelTestTask
//
//  Created by Семен Гайдамакин on 18.12.2023.
//

import Foundation


protocol CustomerProtocol {
    var phone : String { get set }
    var email : String { get set }
    var tourists : [TouristModelProtocol] { get set }
    
    func isFullyFilled() -> Bool
}

struct Customer : CustomerProtocol {
    var phone : String
    var email : String
    var tourists : [TouristModelProtocol]
    
    init(phone: String = "", eamil: String = "", tourists: [TouristModelProtocol] = [TouristModel()]){
        self.phone = phone
        self.email = eamil
        self.tourists = tourists
    }
    
    func isFullyFilled() -> Bool {
        return phone != "" && email != "" && tourists.allSatisfy { $0.isFullyFilled() }
    }

}

protocol TouristModelProtocol {
    var name : String { get set }
    var surname : String { get set }
    var birthday : Optional<Date> { get set }
    var nationality : String { get set }
    var passportID : String { get set }
    var passportValidity : Optional<Date> { get set }
    
    func isFullyFilled() -> Bool
}

struct TouristModel : TouristModelProtocol {
    var name: String
    var surname: String
    var birthday: Optional<Date>
    var nationality: String
    var passportID: String
    var passportValidity: Optional<Date>
    
    init(name: String = "", surname: String = "", birthday: Date = Date(), nationality: String = "", passportID: String = "", passportValidity: Date = Date()) {
        self.name = name
        self.surname = surname
        self.birthday = birthday
        self.nationality = nationality
        self.passportID = passportID
        self.passportValidity = passportValidity
    }
}


extension TouristModelProtocol {
    func isFullyFilled() -> Bool {
        return name != "" && surname != "" && birthday != nil && nationality != "" && passportID != "" && passportValidity != nil
    }
}
