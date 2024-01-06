//
//  FooterView.swift
//  HotelTestTask
//
//  Created by Семен Гайдамакин on 05.01.2024.
//

import Foundation
import UIKit
import SnapKit

class TouristFooterView : UICollectionReusableView {
    
    static let identifier = "TouristFooterView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var buttonCallback : (()->())?

    private let title : UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Добавить туриста"
        return title
    }()

    private lazy var addButton : UIButton = {
        let expandButton = UIButton(type: .custom)
        expandButton.translatesAutoresizingMaskIntoConstraints = false
        expandButton.setImage(UIImage(named: "addIcon"), for: .normal)
        expandButton.backgroundColor = UIColor.SD.blue
        expandButton.layer.cornerRadius = 6
        expandButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
    
        return expandButton
    }()
    
    
    @objc func buttonClicked() {
        buttonCallback?()
    }
    
}
//MARK: - Setup UI
extension TouristFooterView {
    
    private func configureView() {
        layer.cornerRadius = 12
        clipsToBounds = true
        backgroundColor = .white
    }
    
    private func setupUI() {
        addSubview(addButton)
        addButton.snp.makeConstraints { make in
            make.height.equalTo(32)
            make.width.equalTo(32)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-16)
        }
        
        addSubview(title)
        title.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16)
        }
    }
    
}
