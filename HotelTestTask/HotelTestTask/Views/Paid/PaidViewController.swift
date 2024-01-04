//
//  PaidViewController.swift
//  HotelTestTask
//
//  Created by Семен Гайдамакин on 04.01.2024.
//

import Foundation
import UIKit
import SnapKit

class PaidViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = Constants.Title.payed.rawValue
        view.backgroundColor = .white
        navigationItem.hidesBackButton = true
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
        label.text = "Подтвеждение заказа №104893 может занять некоторое время (от 1 часа до суток). Как только мы получим ответ от туроператора вам на почту придет уведомление"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = UIFont.SD.proDisplayFont(size: 17, weight: .thin)
        label.textColor = UIColor.SD.grey
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var superButton = BlueButton(title: "Супер")
    
    @objc
    func superButtonPressed() {
        superButton.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        if let window = UIApplication.shared.windows.first {
            let navController = UINavigationController(rootViewController: MainViewController(viewModel: MainViewModel()))
               window.rootViewController = navController
               window.makeKeyAndVisible()
           }
    }
}


extension PaidViewController {
    
    func setupUI() {
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
}


extension UIImage {
    func resized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
