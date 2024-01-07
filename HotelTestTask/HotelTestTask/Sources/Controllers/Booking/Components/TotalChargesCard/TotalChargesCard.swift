//
//  ToPayView.swift
//  HotelTestTask
//
//  Created by Семен Гайдамакин on 18.12.2023.
//

import Foundation
import UIKit

final class TotalChargesCard: UIView {
    
    var viewModel: BookingViewModel? {
        didSet {
            configure(with: viewModel)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        backgroundColor = .white
        layer.cornerRadius = 15
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // в bookingViewControllere передаем прайс в титл для кнопки
    var setTotalPrice : ((String) -> Void)?
    
    private func configure(with viewModel: BookingViewModel?) {
        guard let booking = viewModel?.bookingData else { return }
        DispatchQueue.main.async { [self] in
            tourPriceValue.text = String(booking.tourPrice) + " ₽"
            fuelChargeValue.text = String(booking.fuelCharge) + " ₽"
            serviceChargeValue.text = String(booking.serviceCharge) + " ₽"
            totalChargeValue.text = String(booking.tourPrice + booking.fuelCharge + booking.serviceCharge) + " ₽"
            totalChargeValue.textColor = UIColor.SD.blue
            setTotalPrice?("Оплатить " + (totalChargeValue.text ?? "Оплатить"))
        }
    }
    
    private let tourPriceLabel = UILabel()
    private let fuelChargeLabel = UILabel()
    private let serviceChargeLabel = UILabel()
    private let totalChargeLabel = UILabel()
    
    
    private let tourPriceValue = UILabel()
    private let fuelChargeValue = UILabel()
    private let serviceChargeValue = UILabel()
    private let totalChargeValue = UILabel()
    
}
    
extension TotalChargesCard {
    // Установка и настройка интерфейса
    private func setupUI() {
        // Засунули в вертикальный стак горизональные стаки createInfoStack(...)
        // Якоря.
        // Настроили все лейблы в configureLabels() через configureLabel
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false

        stackView.addArrangedSubview(createInfoStack(titleLabel: tourPriceLabel, valueLabel: tourPriceValue))
        stackView.addArrangedSubview(createInfoStack(titleLabel: fuelChargeLabel, valueLabel: fuelChargeValue))
        stackView.addArrangedSubview(createInfoStack(titleLabel: serviceChargeLabel, valueLabel: serviceChargeValue))
        stackView.addArrangedSubview(createInfoStack(titleLabel: totalChargeLabel, valueLabel: totalChargeValue))


        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
        configureLabels()
    }
    
    // Настроили содержимое лейблов
    private func configureLabels() {
        configureLabel(titleLabel: tourPriceLabel, valueLabel: tourPriceValue, title: "Тур", color: .gray, leadingConstant: 16)
        configureLabel(titleLabel: fuelChargeLabel, valueLabel: fuelChargeValue, title: "Топливный сбор", color: .gray, leadingConstant: 16)
        configureLabel(titleLabel: serviceChargeLabel, valueLabel: serviceChargeValue, title: "Сервисный сбор", color: .gray, leadingConstant: 16)
        configureLabel(titleLabel: totalChargeLabel, valueLabel: totalChargeValue, title: "К оплате", color: .gray, leadingConstant: 16)
    }
    
    // Настройка лейбла
    private func configureLabel(titleLabel: UILabel, valueLabel: UILabel, title: String, color: UIColor, leadingConstant: CGFloat) {
        titleLabel.text = title
        titleLabel.textColor = color
        titleLabel.font = UIFont.SD.proDisplayFont(size: 16, weight: .thin)
        
        valueLabel.textColor = .black
        valueLabel.textAlignment = .right
        valueLabel.font = UIFont.SD.proDisplayFont(size: 16, weight: .medium)
        valueLabel.numberOfLines = 0
        valueLabel.lineBreakMode = .byWordWrapping

        // Добавление ограничений
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalToConstant: 120),
            valueLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 150),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leadingConstant),
            valueLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8),
            valueLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -16),
        ])
    }
    
    // Создание стека с заголовком и значением
    private func createInfoStack(titleLabel: UILabel, valueLabel: UILabel) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .firstBaseline
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(valueLabel)
        return stackView
    }
}


    
  

  

    

