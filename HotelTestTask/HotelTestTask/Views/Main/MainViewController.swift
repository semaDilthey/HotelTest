//
//  MainViewController.swift
//  HotelTestTask
//
//  Created by Семен Гайдамакин on 15.12.2023.
//

import Foundation
import UIKit

final class MainViewController : UIViewController {
        
    let viewModel : MainViewModel
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = Constants.Title.hotel.rawValue
        UINavigationBar.appearance().barTintColor = .white
        view.backgroundColor = .white
        
        viewModel.getHotel { [weak self] in
            DispatchQueue.main.async {
                self?.sendDataToCards(hotel: self?.viewModel.hotels ?? [])
                self?.presentationCard.pagingCollectionView.collectionView.reloadData()
                self?.presentationCard.pagingCollectionView.collectionView.layoutIfNeeded()
            }
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupUI()
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height+220)
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        scrollView.scrollToTop()
    }
    
    private func sendDataToCards(hotel : [Hotel]) {
        presentationCard.hotel = hotel.first
        informationCard.hotel = hotel.first
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
    
    lazy var chooseButton : BlueButton = {
        let chooseButton = BlueButton(title: "К выбору отеля")
        chooseButton.translatesAutoresizingMaskIntoConstraints = false
        chooseButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return chooseButton
    }()
    
    @objc
    func buttonTapped() {
        // По хорошему надо нормально делать, но поскольку объект у нас один
        // то решил на это время не тратить
        guard let id = viewModel.hotels?.first?.id else { return }
        // создаем и прокидываем данные комнат создавая в этой вьюмодели в следуюущую
        let data = viewModel.getRooms(id: id, rooms: viewModel.getRooms())
        viewModel.coordinagor.showwRoomsViewController(controller: navigationController!, data: data, hotelName: /*presentationCard.hotelName.text ??*/ "Комнаты") // да простят меня боги, nav controller всегда имеется поэтому форс дабы не громоздить гуарды
    }
}

extension MainViewController {
    
    private func setupUI() {
        
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
            informationCard.heightAnchor.constraint(equalToConstant: 530),
            informationCard.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

        ])
        
        view.addSubview(chooseButton)
        NSLayoutConstraint.activate([
            chooseButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.Sizes.bigGap),
            chooseButton.heightAnchor.constraint(equalToConstant: 49),
            chooseButton.topAnchor.constraint(equalTo: informationCard.bottomAnchor, constant: 24),
            chooseButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.Sizes.bigGap)

        ])
    
    }

}



extension UIScrollView {
    func scrollToTop() {
        let desiredOffset = CGPoint(x: 0, y: -contentInset.top - 100)
        setContentOffset(desiredOffset, animated: true)
   }
}
