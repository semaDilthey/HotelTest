//
//  RoomsViewController.swift
//  HotelTestTask
//
//  Created by Семен Гайдамакин on 15.12.2023.
//

import Foundation
import UIKit

class RoomsViewController : UITableViewController {
    
    var viewModel : RoomViewModel
    
    init(viewModel: RoomViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigationBar()
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RoomsCell.self, forCellReuseIdentifier: RoomsCell.identifier)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.SD.greyLight
        tableView.showsVerticalScrollIndicator = false
        tableView.bounces = false
    }
    
    private func setupNavigationBar() {
        let backButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(backButtonPressed))
        navigationItem.hidesBackButton = false
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc
    func backButtonPressed() {
        let vc = MainViewController(viewModel: MainViewModel())
        navigationController?.popViewController(animated: true)
    }
        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RoomsCell.identifier, for: indexPath) as? RoomsCell else {
            return UITableViewCell()
        }
        guard let viewModel = viewModel.getRoomModel(at: indexPath) else {
            return UITableViewCell()
        }
        cell.set(model: viewModel)
        cell.buttonTapped = { [weak self] in
            // передаем во вьюмодель id комнаты и там уже подгружаем нужную информацию по id. 
            // Можно конечно было и просто открыть ибо букинг там 1 но энивей
            let roomID = viewModel.id
            print("roomID \(viewModel.id)")
            self?.viewModel.openBooking(with: roomID, navController: self?.navigationController)
        }
        cell.backgroundColor = UIColor.SD.greyLight
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.rooms != nil {
            return viewModel.rooms?.count ?? 0
        } else {
            print("Cant draw cells for model, because data is empty")
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 548
    }
}

