//
//  MainTableVIew.swift
//  HotelTestTask
//
//  Created by Семен Гайдамакин on 05.01.2024.
//

import Foundation
import UIKit

class MainTableView : UITableView {
    
    var model : [MainTableModelProtocol]?
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setupTable()
        configureModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureModel() {
        model = [MainTableModel(image: UIImage(named: "emoji-happy")!, article: "Удобства", properties: "Самое необходимое"),
                 MainTableModel(image: UIImage(named: "tick-square")!, article: "Что включено", properties: "Самое необходимое"),
                 MainTableModel(image: UIImage(named: "close-square")!, article: "Что не включено", properties: "Самое необходимое")]
    }
    
    private func setupTable() {
        register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.identifier)
        delegate = self
        dataSource = self
        backgroundColor = .clear
        layer.cornerRadius = 15
        clipsToBounds = true
    }
}

extension MainTableView : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.count ?? 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as! MainTableViewCell
        cell.set(with: model!, indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        65
    }
}
