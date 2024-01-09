//
//  PaidViewController.swift
//  HotelTestTask
//
//  Created by Семен Гайдамакин on 04.01.2024.
//

import Foundation
import UIKit
import SnapKit

final class PaidViewController : UIViewController {
     
    private(set) var viewModel : PaidViewModel
    
    init(viewModel : PaidViewModel) {
        self.viewModel = viewModel
        // имитация того что каждый раз приходит разных номер бронирования, но в нашей апишке его нет
        defer { viewModel.configure(label: notifyLabel) }
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationBar()
    }
 
    private let image : UIImageView = {
        let imageVIew = UIImageView()
        imageVIew.image = UIImage(named: "paidCongrats")?.resized(to: CGSize(width: 44, height: 44))
        imageVIew.translatesAutoresizingMaskIntoConstraints = false
        return imageVIew
    }()
    
    private let confirmationLabel : UILabel = {
        let label = UILabel()
        label.text = "Ваш заказ принят в работу"
        label.numberOfLines = 0
        label.font = UIFont.SD.proDisplayFont(size: 22, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let notifyLabel : UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = UIFont.SD.proDisplayFont(size: 17, weight: .thin)
        label.textColor = UIColor.SD.grey
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var superButton = BlueButton(title: "Супер")
    
    @objc func superButtonPressed() {
        viewModel.coordinator?.start()
    }
}


extension PaidViewController {
    
    private func setupUI() {
        let stack = UIStackView(arrangedSubviews: [confirmationLabel, notifyLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 20
        
        let finalStack = UIStackView(arrangedSubviews: [image, stack])
        finalStack.translatesAutoresizingMaskIntoConstraints = false
        finalStack.axis = .vertical
        finalStack.alignment = .center
        finalStack.spacing = 32
        
        view.addSubview(finalStack)
        finalStack.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(23)
            make.right.equalToSuperview().offset(-23)
        }
        
        view.addSubview(superButton)
        superButton.translatesAutoresizingMaskIntoConstraints = false
        superButton.addTarget(self, action: #selector(superButtonPressed), for: .touchUpInside)
        superButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.left.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-28)
            make.height.equalTo(48)
        }
    }
    
    private func setupNavigationBar() {
        navigationItem.title = Constants.Title.payed.rawValue
        view.backgroundColor = .white
        navigationItem.hidesBackButton = true
    }
}
