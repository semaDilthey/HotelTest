//
//  CustomerInfoCard.swift
//  HotelTestTask
//
//  Created by Семен Гайдамакин on 18.12.2023.
//

import Foundation
import UIKit
import CocoaTextField

protocol CustomerDelegate : TouristDelegate {
    func didUpdateCustomer(email: String)
    func didUpdateCustomer(phone: String)
}

class CustomerInfoCard : UIView {
    
    var delegate : CustomerDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let title : UILabel = {
        let title = UILabel()
        title.text = "Информация о покупателе"
        title.font = UIFont.SD.proDisplayFont(size: 22, weight: .medium)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    let phoneTextField = createCocoaTextField(placeholder: "Номер телефона")
    let emailTextFiled = createCocoaTextField(placeholder: "email")
    
    static func createCocoaTextField(placeholder: String) -> CocoaTextField {
        let phoneTextField = CocoaTextField()
        phoneTextField.translatesAutoresizingMaskIntoConstraints = false
        phoneTextField.borderColor = .clear
        phoneTextField.defaultBackgroundColor = UIColor.SD.greyLight!
        phoneTextField.focusedBackgroundColor = UIColor.SD.greyLight!
        phoneTextField.placeholder = placeholder
        phoneTextField.font = UIFont.SD.proDisplayFont(size: 16, weight: .thin)
        phoneTextField.activeHintColor = UIColor.SD.grey!
        return phoneTextField
    }
    
    private let noticeLabel : UILabel = {
        let noticeLabel = UILabel()
        noticeLabel.translatesAutoresizingMaskIntoConstraints = false
        noticeLabel.text = "Эти данные никому не передаются. После оплаты мы вышлем чек на указанный вами номер и почту"
        noticeLabel.font = UIFont.SD.proDisplayFont(size: 14, weight: .thin)
        noticeLabel.textColor = UIColor.SD.grey
        noticeLabel.numberOfLines = 0
        noticeLabel.lineBreakMode = .byWordWrapping
        return noticeLabel
    }()
}

//MARK: - SetupUI
extension CustomerInfoCard {
    
    private func setupUI(){
        backgroundColor = .white
        layer.cornerRadius = 15
        phoneTextField.delegate = self
        emailTextFiled.delegate = self
        phoneTextField.keyboardType = .numberPad
        
        addSubview(title)
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            title.topAnchor.constraint(equalTo: topAnchor, constant: 16)
        ])
        
        addSubview(phoneTextField)
        NSLayoutConstraint.activate([
            phoneTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            phoneTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            phoneTextField.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 20),
            phoneTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        addSubview(emailTextFiled)
        NSLayoutConstraint.activate([
            emailTextFiled.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            emailTextFiled.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            emailTextFiled.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 8),
            emailTextFiled.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        addSubview(noticeLabel)
        NSLayoutConstraint.activate([
            noticeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            noticeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            noticeLabel.topAnchor.constraint(equalTo: emailTextFiled.bottomAnchor, constant: 8)
        ])
    }
}

//MARK: - UITextFieldDelegate

extension CustomerInfoCard : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == phoneTextField {
            textField.text = "+7 (XXX) XXX-XXXX"
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       
        configureTextFiled(textFields: [emailTextFiled, phoneTextField])
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
      
        if textField == phoneTextField {
            textField.text = Formatter.format(with: "+Y (XXX) XXX-XXXX", phone: newString)
            
        } else if textField == emailTextFiled {
            textField.text = newString
        }
        return false
        }
}

extension CustomerInfoCard {
    // конфигурирую делегат текстфилда датбы не плодить кучу кода тамс
    private func configureTextFiled(textFields: [CocoaTextField]) {
        for field in textFields {
            if field.isEditing {
                field.resignFirstResponder()
                if field == emailTextFiled {
                    if Validator.isValidEmail(email: field.text ?? "") {
                        field.borderColor = .clear
                        field.placeholder = "Введите емайл"
                        delegate?.didUpdateCustomer(email: field.text ?? "")
                    } else {
                        field.borderColor = .red
                        field.placeholder = "Введите корректный емайл"
                        field.text = ""
                        field.activeHintColor = .red
                    }
                }
                if field == phoneTextField {
                    if field.text?.count == 17 {
                        field.borderColor = .clear
                        field.placeholder = "Введите номер"
                        delegate?.didUpdateCustomer(phone: field.text ?? "")
                    } else {
                        field.borderColor = .red
                        field.placeholder = "Введите корректный номер"
                        field.text = ""
                        field.activeHintColor = .red
                    }
                }
            }
        }
    }
    
}
