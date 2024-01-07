//
//  MainViewController.swift
//  HotelTestTask
//
//  Created by Семен Гайдамакин on 15.12.2023.
//

import Foundation
import UIKit

final class MainViewController : UIViewController {
        
    private(set) var viewModel : MainViewModel
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setupUI()
        
        handleViewMode()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height+140)
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        scrollView.scrollToTop()
    }
    
    let scrollView : UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.isDirectionalLockEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = UIColor.SD.greyLight
        scrollView.isScrollEnabled = true
        scrollView.bounces = false
        return scrollView
    }()

    private let presentationCard = PresentationCardView()
    
    private let informationCard = InformationViewCard()
    
    private lazy var chooseButton : BlueButton = {
        let chooseButton = BlueButton(title: "К выбору отеля")
        chooseButton.translatesAutoresizingMaskIntoConstraints = false
        chooseButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return chooseButton
    }()
    
    private func handleViewMode() {
        viewModel.getHotel { [weak self] in
            DispatchQueue.main.async {
                self?.bindCards(with: self?.viewModel.hotels ?? [])
            }
        }
    }
    
    private func bindCards(with binding : [Hotel]) {
        presentationCard.binding = binding.first
        informationCard.binding = binding.first
        
        presentationCard.pagingCollectionView.collectionView.reloadData()
        presentationCard.pagingCollectionView.collectionView.layoutIfNeeded()
    }
    
    @objc func buttonTapped() {
        
        animateSize(view: chooseButton)
        // По хорошему надо нормально делать, но поскольку объект у нас один
        // то решил на это время не тратить
        guard let id = viewModel.hotels?.first?.id else { return }
        // создаем и прокидываем данные комнат создавая в этой вьюмодели в следуюущую
        let data = viewModel.getRooms(id: id, rooms: viewModel.getRooms())
        viewModel.coordinator?.navigateTo(controller: .roomsController(rooms: data, hotelName: "Номера"))
        #warning("Тут убрал метод, настроить его в некст тайм")
//        viewModel.coordinator.showwRoomsViewController(controller: navigationController!, data: data, hotelName: "Номера")
    }
}

extension MainViewController {
    
    private func setNavigationBar() {
        navigationItem.title = Constants.Title.hotel.rawValue
        UINavigationBar.appearance().barTintColor = .white
    }
    
    private func setupUI() {
        view.backgroundColor = .white

        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        presentationCard.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(presentationCard)
        NSLayoutConstraint.activate([
            presentationCard.topAnchor.constraint(equalTo: scrollView.topAnchor),
            presentationCard.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            presentationCard.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            presentationCard.heightAnchor.constraint(equalToConstant: 458),
            presentationCard.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

        ])
        
        informationCard.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(informationCard)
        NSLayoutConstraint.activate([
            informationCard.topAnchor.constraint(equalTo: presentationCard.bottomAnchor, constant: Constants.Sizes.smallGap),
            informationCard.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            informationCard.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            informationCard.heightAnchor.constraint(equalToConstant: 454),
            informationCard.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

        ])
        
        view.addSubview(chooseButton)
        NSLayoutConstraint.activate([
            chooseButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.Sizes.bigGap),
            chooseButton.heightAnchor.constraint(equalToConstant: 49),
            chooseButton.topAnchor.constraint(equalTo: informationCard.bottomAnchor, constant: 16),
            chooseButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.Sizes.bigGap)

        ])
    }
}


extension UIViewController {
    
    func animateSize(view : UIView) {
        UIView.animate(withDuration: 0.25, animations: {
            // Уменьшаем размер ячейки
            self.view.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { _ in
            // Восстанавливаем размер ячейки после завершения анимации
            UIView.animate(withDuration: 0.25) {
                self.view.transform = CGAffineTransform.identity
            }
        }
    }
}

