//
//  RoomsViewController.swift
//  HotelTestTask
//
//  Created by Семен Гайдамакин on 15.12.2023.
//

import Foundation
import UIKit

final class RoomsViewController : UITableViewController {
    
    private(set) var viewModel : RoomViewModel
    
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
        handleViewModel()
    }
    
    private func handleViewModel() {
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

    @objc func backButtonPressed() {
//        let vc = MainViewController(viewModel: MainViewModel(coordinator: Coordinator()))
        navigationController?.popViewController(animated: true)
        viewModel.coordinator?.dismiss()
    }
}

//MARK: - UITableViewDataSource
extension RoomsViewController {
    
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
//            self?.viewModel.openBooking(with: viewModel.id, navController: self?.navigationController)
            self?.viewModel.coordinator?.navigateTo(controller: .bookingController(roomID: viewModel.id))

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

extension RoomsViewController {
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.register(RoomsCell.self, forCellReuseIdentifier: RoomsCell.identifier)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.SD.greyLight
        tableView.showsVerticalScrollIndicator = false
        tableView.bounces = false
    }
    
    private func setupNavigationBar() {
        let customButton = UIBarButtonItem(image: UIImage(named: "backButton"), style: .plain, target: self, action: #selector(backButtonPressed))
        navigationItem.hidesBackButton = false
        navigationItem.leftBarButtonItem = customButton
        navigationItem.leftBarButtonItem?.imageInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
    }
    
}
