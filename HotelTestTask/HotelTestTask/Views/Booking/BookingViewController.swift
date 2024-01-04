//
//  BookingViewController.swift
//  HotelTestTask
//
//  Created by Семен Гайдамакин on 17.12.2023.
//

import Foundation
import UIKit

final class BookingViewController: UIViewController {
    
    private(set) var viewModel : BookingViewModel

    init(viewModel: BookingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        setupUI()
        setupNavigationBar()
        
        loadingHandler()
        buttonPriceHandler()
        customerInfoCard.delegate = self
        touristCollectionView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateLayoutSize()
        toPayButton.addTarget(self, action: #selector(payButtonPressed), for: .touchUpInside)
    }
    
    lazy var scrollView = UIScrollView(frame: .zero)
    
    private let bookingInfoCard = BookingInfoCard()
    private let customerInfoCard = CustomerInfoCard()
    
    private let touristCollectionView = TouristCollectionView()
    
    private let totalChargesCard = TotalChargesCard()
    
    lazy var toPayButton = BlueButton(title: "Оплатить")
    
    @objc
    func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    func payButtonPressed() {
        
        if viewModel.customer.isFullyFilled() {
            viewModel.coordinator.showPaidController(controller: navigationController)
            
        } else {
            
            if viewModel.customer.email == "" {
                customerInfoCard.emailTextFiled.borderColor = .red
            }
            
            if viewModel.customer.phone == "" {
                customerInfoCard.phoneTextField.borderColor = .red
            }
        }
        
    }

}

//MARK: - CallBacks
extension BookingViewController {
    // рассчитывает размер touristCollectionView в зависимости от
    // размера collectionViewContentSize через кложуру sendSize
    private func updateLayoutSize() {

        touristCollectionView.sendSize = { [weak self] size in
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.3) {
                    self?.touristCollectionView.constraints.first?.isActive = false
                    self?.touristCollectionView.heightAnchor.constraint(equalToConstant: size).isActive = true
                    self?.scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height+size+20)
                }
                self?.view.layoutIfNeeded()
            }
        }
    }
    
    // Прокидываем загруженные данные в чайлдвьюхи
    private func loadingHandler() {
        viewModel.loadBooking() { [weak self] in
            guard let viewModel = self?.viewModel else { return }
            self?.bookingInfoCard.viewModel = viewModel
            self?.totalChargesCard.viewModel = viewModel
        }
    }
    
    // получаем прайс в титл нашей кнопки оплаты
    private func buttonPriceHandler() {
        totalChargesCard.configTotalPrice = { total in
            DispatchQueue.main.async { [weak self] in
                self?.toPayButton.title = total
            }
        }
    }
}
 //MARK: - Setup UI Components
extension BookingViewController {
    
    private func setupScrollView() {
        scrollView.isDirectionalLockEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = UIColor.SD.greyLight
        scrollView.isScrollEnabled = true
        scrollView.bounces = true
        
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupUI() {
        scrollView.addSubview(bookingInfoCard)
        bookingInfoCard.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bookingInfoCard.topAnchor.constraint(equalTo: scrollView.topAnchor),
            bookingInfoCard.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bookingInfoCard.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bookingInfoCard.heightAnchor.constraint(equalToConstant: 416)
        ])
        
        scrollView.addSubview(customerInfoCard)
        customerInfoCard.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            customerInfoCard.topAnchor.constraint(equalTo: bookingInfoCard.bottomAnchor, constant: 13),
            customerInfoCard.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customerInfoCard.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customerInfoCard.heightAnchor.constraint(equalToConstant: 230)
        ])
        
        scrollView.addSubview(touristCollectionView)
        touristCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            touristCollectionView.topAnchor.constraint(equalTo: customerInfoCard.bottomAnchor, constant: 0),
            touristCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            touristCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            touristCollectionView.heightAnchor.constraint(equalToConstant: 124)
        ])
        
        scrollView.addSubview(totalChargesCard)
        totalChargesCard.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            totalChargesCard.topAnchor.constraint(equalTo: touristCollectionView.bottomAnchor, constant: 8),
            totalChargesCard.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            totalChargesCard.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            totalChargesCard.heightAnchor.constraint(equalToConstant: 156)
        ])
        
        scrollView.addSubview(toPayButton)
        toPayButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            toPayButton.topAnchor.constraint(equalTo: totalChargesCard.bottomAnchor, constant: 8),
            toPayButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            toPayButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            toPayButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    private func setupNavigationBar() {
        navigationItem.title = Constants.Title.booking.rawValue
        let backButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(backButtonPressed))
        navigationItem.hidesBackButton = false
        navigationItem.leftBarButtonItem = backButton
    }
}



extension BookingViewController : CustomerDelegate {
    func didUpdateCustomer(email: String) {
        viewModel.customer.email = email
    }
    
    func didUpdateCustomer(phone: String) {
        viewModel.customer.phone = phone
    }
    
    func didUpdateTourist(tourist: TouristModelProtocol,at : IndexPath) {
        guard at.row < touristCollectionView.torists.count else { return }
        
        viewModel.customer.tourists.insert(tourist, at: at.row)
        
        if viewModel.customer.tourists.count > touristCollectionView.torists.count {
            viewModel.customer.tourists.removeLast()
        }
    }
    
    
}
