//
//  TouristCollectionView.swift
//  HotelTestTask
//
//  Created by Семен Гайдамакин on 25.12.2023.
//

import UIKit
import SnapKit

class TouristCollectionView: UIView {
    
    // sendSize отвечает за передачу размера лэйаута в BookingViewController
    var sendSize : ((_ sizee : CGFloat)-> ())?
    var delegate : CustomerDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        selectCell(at: 0, section: 0)
    }
    
    var toruist : TouristModelProtocol? = TouristModel()
    var touristCallback : ((TouristModelProtocol?) -> Void)!
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        sendSize?(collectionView.collectionViewLayout.collectionViewContentSize.height)
    }
    
    // устанавливаем первую ячейку открытой по умолчанию
    private func selectCell(at row: Int, section: Int) {
        let indexPath = IndexPath(row: row, section: section)
        collectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
    }
    
    var torists : [TouristModelProtocol] = [TouristModel(name: "Sasha", surname: "Sasha", birthday: Date(), nationality: "Sasha", passportID: "Sasha", passportValidity: Date()), TouristModel(name: "Sasha", surname: "Sasha", birthday: Date(), nationality: "Sasha", passportID: "Sasha", passportValidity: Date())]    
    
    
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.showsVerticalScrollIndicator = false
        view.allowsMultipleSelection = true
        view.alwaysBounceVertical = true
        view.delegate = self
        view.dataSource = self
        
        return view
    }()
    
    private func addTourist() {
        if torists.count < 4 {
            torists.append(TouristModel(name: "", surname: "", birthday: Date(), nationality: "", passportID: "", passportValidity: Date()))
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        } else {
            print("Maximum number of tourists is reached")
        }
    }
    
    private func configureView() {
        backgroundColor = .white
        clipsToBounds = true
        layer.cornerRadius = 12
        collectionView.backgroundColor = UIColor.SD.greyLight
        
        collectionView.register(TouristCell.self, forCellWithReuseIdentifier: TouristCell.identifier)
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
}



extension TouristCollectionView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if torists.count > 2 {
            DispatchQueue.main.async {
                self.sendSize?(collectionView.collectionViewLayout.collectionViewContentSize.height)
            }
            return torists.count
        } else {
            return 2
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TouristCell.identifier, for: indexPath) as! TouristCell
        cell.buttonCallback = {
            self.addTourist()
        }

//        delegate?.didUpdateTourist(tourist: TouristModel(name: "Vasya Masha"), at: indexPath)
        cell.updateTourist = { tourist in
            self.delegate?.didUpdateTourist(tourist: tourist, at: indexPath)
            print("tourist \(tourist)")
        }
        cell.configureTitle(for: indexPath)
        return cell
    }
}

extension TouristCollectionView : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let isSelected = collectionView.indexPathsForSelectedItems?.contains(indexPath) ?? false
        return CGSize(width: collectionView.bounds.width, height: isSelected ? 410 : 54)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        8
    }
}

extension TouristCollectionView : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        collectionView.deselectItem(at: indexPath, animated: true)
        collectionView.performBatchUpdates(nil)
        sendSize?(collectionView.collectionViewLayout.collectionViewContentSize.height)
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
        collectionView.performBatchUpdates(nil)
        sendSize?(collectionView.collectionViewLayout.collectionViewContentSize.height)
        return true
    }
}
