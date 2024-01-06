//
//  BookingInfoChildView.swift
//  HotelTestTask
//
//  Created by Семен Гайдамакин on 18.12.2023.
//

import Foundation
import UIKit

class BookingInfoBookingCard: UIView {

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
    
    func configure(with viewModel: BookingViewModel?) {
        guard let booking = viewModel?.bookingData else { return }
        DispatchQueue.main.async { [self] in
            departureValueLabel.text = booking.departure
            locationValueLabel.text = booking.arrivalCountry
            dateValueLabel.text = booking.tourDateStart + " - " + booking.tourDateStop
            nightsValueLabel.text = String(booking.numberOfNights)
            hotelValueLabel.text = booking.hotelName
            roomValueLabel.text = booking.room
            foodValueLabel.text = booking.nutrition
        }
    }

    let departureTitleLabel = UILabel()
    let locationTitleLabel = UILabel()
    let dateTitleLabel = UILabel()
    let nightsTitleLabel = UILabel()
    let hotelTitleLabel = UILabel()
    let roomTitleLabel = UILabel()
    let foodTitleLabel = UILabel()

    let departureValueLabel = UILabel()
    let locationValueLabel = UILabel()
    let dateValueLabel = UILabel()
    let nightsValueLabel = UILabel()
    let hotelValueLabel = UILabel()
    let roomValueLabel = UILabel()
    let foodValueLabel = UILabel()


    // Установка и настройка интерфейса
    private func setupUI() {
        // Засунули в вертикальный стак горизональные стаки createInfoStack(...)
        // Якоря.
        // Настроили все лейблы в configureLabels() через configureLabel
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false

        stackView.addArrangedSubview(createInfoStack(titleLabel: departureTitleLabel, valueLabel: departureValueLabel))
        stackView.addArrangedSubview(createInfoStack(titleLabel: locationTitleLabel, valueLabel: locationValueLabel))
        stackView.addArrangedSubview(createInfoStack(titleLabel: dateTitleLabel, valueLabel: dateValueLabel))
        stackView.addArrangedSubview(createInfoStack(titleLabel: nightsTitleLabel, valueLabel: nightsValueLabel))
        stackView.addArrangedSubview(createInfoStack(titleLabel: hotelTitleLabel, valueLabel: hotelValueLabel))
        stackView.addArrangedSubview(createInfoStack(titleLabel: roomTitleLabel, valueLabel: roomValueLabel))
        stackView.addArrangedSubview(createInfoStack(titleLabel: foodTitleLabel, valueLabel: foodValueLabel))

        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
        configureLabels()
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

    // Настроили содержимое лейблов
    private func configureLabels() {
        configureLabel(titleLabel: departureTitleLabel, valueLabel: departureValueLabel, title: "Вылет из", color: .gray, leadingConstant: 16)
        configureLabel(titleLabel: locationTitleLabel, valueLabel: locationValueLabel, title: "Страна, город", color: .gray, leadingConstant: 16)
        configureLabel(titleLabel: dateTitleLabel, valueLabel: dateValueLabel, title: "Даты", color: .gray, leadingConstant: 16)
        configureLabel(titleLabel: nightsTitleLabel, valueLabel: nightsValueLabel, title: "Кол-во ночей", color: .gray, leadingConstant: 16)
        configureLabel(titleLabel: hotelTitleLabel, valueLabel: hotelValueLabel, title: "Отель", color: .gray, leadingConstant: 16)
        configureLabel(titleLabel: roomTitleLabel, valueLabel: roomValueLabel, title: "Номер", color: .gray, leadingConstant: 16)
        configureLabel(titleLabel: foodTitleLabel, valueLabel: foodValueLabel, title: "Питание", color: .gray, leadingConstant: 16)
    }

    // Настройка лейбла
    private func configureLabel(titleLabel: UILabel, valueLabel: UILabel, title: String, color: UIColor, leadingConstant: CGFloat) {
        titleLabel.text = title
        titleLabel.textColor = color
        titleLabel.font = UIFont.SD.proDisplayFont(size: 16, weight: .thin)
        
        valueLabel.textColor = .black
        valueLabel.textAlignment = .left
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
}


