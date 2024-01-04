//
//  PagingCollection.swift
//  HotelTestTask
//
//  Created by Семен Гайдамакин on 15.12.2023.
//

import Foundation
import UIKit
import SnapKit

class PagingCollectionView: UIView {

    var imagesURL: [String] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPager()
        setupCollectionView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .lightGray
//        pageControl.numberOfPages = 3
        pageControl.backgroundColor = .white.withAlphaComponent(0.5)
        pageControl.backgroundStyle = .minimal
        pageControl.layer.cornerRadius = 2
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.register(PagingCollectionViewCell.self, forCellWithReuseIdentifier: PagingCollectionViewCell.identifier)
        collectionView.collectionViewLayout = createLayout()

        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        layer.cornerRadius = 15
        clipsToBounds = true
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    private func setupPager() {
        addSubview(pageControl)
        pageControl.layer.zPosition = +1

        pageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-8)
        }
    }

}
//MARK: - UICollectionViewDataSource/ UICollectionViewDelegate
extension PagingCollectionView : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesURL.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PagingCollectionViewCell.identifier, for: indexPath) as? PagingCollectionViewCell else {
            return UICollectionViewCell()
        }
        let image = imagesURL[indexPath.item]
        cell.configure(imageURL: image)
        pageControl.numberOfPages = imagesURL.count
        return cell
    }
}

//MARK: - Compositional Layout
extension PagingCollectionView {
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionNumber, evf ->
              NSCollectionLayoutSection? in
              switch sectionNumber {
              case 0: return self.createSection()
              default: return self.createSection()
              }
           }
       }
    
    private func createLayoutItem(widthFraction: CGFloat, heightFraction: CGFloat) -> NSCollectionLayoutItem {
         let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(widthFraction), heightDimension: .fractionalHeight(heightFraction))
         let item = NSCollectionLayoutItem(layoutSize: itemSize)
         return item
     }
    
     // Функция создания layout group
    private func createGroup(layoutSize: NSCollectionLayoutSize, subitems: [NSCollectionLayoutItem]) -> NSCollectionLayoutGroup {
         return NSCollectionLayoutGroup.horizontal(layoutSize: layoutSize, subitems: subitems)
         }
   
     
      private func createSection() -> NSCollectionLayoutSection {
          let item = createLayoutItem(widthFraction: 1, heightFraction: 1)
          let group = createGroup(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(257)), subitems: [item])
          let section = NSCollectionLayoutSection(group: group)
          section.orthogonalScrollingBehavior = .paging
          section.visibleItemsInvalidationHandler = { [weak self] (items, offset, env) in
              // обновляем страницу pageControla
              let currentPage = Int(offset.x / (self?.bounds.width ?? 500))
              self?.pageControl.currentPage = currentPage
          }
          return section
     }
    
}
