//
//  MainTableViewCel;.swift
//  HotelTestTask
//
//  Created by Семен Гайдамакин on 05.01.2024.
//

import Foundation
import UIKit
import SnapKit

class MainTableViewCell : UITableViewCell {
    
    static let identifier = "MainTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(with model: [MainTableModelProtocol], indexPath: IndexPath) {
        image.image = model[indexPath.row].image
        articleLabel.text = model[indexPath.row].article
        propertiesLabel.text = model[indexPath.row].properties
    }
    
    private let image : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let articleLabel : UILabel = {
        let articleLabel = UILabel()
        articleLabel.translatesAutoresizingMaskIntoConstraints = false
        articleLabel.font = UIFont.SD.proDisplayFont(size: 16, weight: .medium)
        return articleLabel
    }()
    
    private let propertiesLabel : UILabel = {
        let propertiesLabel = UILabel()
        propertiesLabel.translatesAutoresizingMaskIntoConstraints = false
        propertiesLabel.font = UIFont.SD.proDisplayFont(size: 14, weight: .medium)
        propertiesLabel.textColor = UIColor.SD.grey
        return propertiesLabel
    }()
    
    private lazy var expandButton : UIButton = {
        let expandButton = UIButton()
        expandButton.translatesAutoresizingMaskIntoConstraints = false
        expandButton.setImage(UIImage(named: "expandImage"), for: .normal)
        return expandButton
    }()
}

//MARK: - Setting up UI
extension MainTableViewCell {
    
    private func setupUI() {
        backgroundColor = UIColor.SD.greyLight?.withAlphaComponent(0.3)
        let labelsStack = createStack(views: [articleLabel, propertiesLabel], alignment: .leading, axis: .vertical, spacing: 4)
        let imageAndLabelsStack = createStack(views: [image, labelsStack], alignment: .center, axis: .horizontal, spacing: 12)
        
        contentView.addSubview(imageAndLabelsStack)
        imageAndLabelsStack.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-15)
        }
        
        contentView.addSubview(expandButton)
        expandButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(22)
            make.right.bottom.equalToSuperview().offset(-15)
        }
    }
    
    private func createStack(views : [UIView], alignment : UIStackView.Alignment, axis : NSLayoutConstraint.Axis, spacing : CGFloat, distribution : UIStackView.Distribution = .equalSpacing) -> UIStackView {
        let stack = UIStackView(arrangedSubviews: views)
        stack.alignment = alignment
        stack.axis = axis
        stack.spacing = spacing
        stack.distribution = distribution
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }
    
}
