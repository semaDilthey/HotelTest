//
//  TagViewCollectionView.swift
//  HotelTestTask
//
//  Created by Семен Гайдамакин on 16.12.2023.
//

import Foundation
import UIKit

class TagViewCollectionView: UICollectionView {
    
    var dataStorage: [String] = []
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: leftLayout)
        setupCollectionView()
        leftLayout.collectionView?.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let leftLayout : AlignedCollectionViewFlowLayout = {
        let layout = AlignedCollectionViewFlowLayout(horizontalAlignment: .leading)
        layout.estimatedItemSize = .init(width: 100, height: 29)
        layout.collectionView?.isScrollEnabled = false
        layout.minimumInteritemSpacing = Constants.Sizes.smallGap
        layout.minimumLineSpacing = Constants.Sizes.smallGap
        return layout
    }()
    
    private func setupCollectionView() {
        dataSource = self
        register(TagViewCell.self, forCellWithReuseIdentifier: TagViewCell.identifier)
        isUserInteractionEnabled = false
        backgroundColor = .clear
    }
}

extension TagViewCollectionView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataStorage.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagViewCell.identifier, for: indexPath) as? TagViewCell else {
            return UICollectionViewCell()
        }

        let tag = dataStorage[indexPath.row]
        cell.configure(text: tag)
        return cell
    }
    
}

