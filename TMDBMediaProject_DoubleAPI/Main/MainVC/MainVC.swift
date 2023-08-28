//
//  MainVC.swift
//  TMDBMediaProject_DoubleAPI
//
//  Created by 염성필 on 2023/08/28.
//

import UIKit

class MainVC: BaseView {
    
    let headerView = MainCVHeaderCell()
    
    lazy var collectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: settingCollectionViewLayout())
        view.register(MainCVCell.self, forCellWithReuseIdentifier: String(describing: MainCVCell.self))
        view.register(MainCVHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: MainCVHeaderCell.self))
        return view
    }()
    
    func settingCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let spacing: CGFloat = 5
        let width = UIScreen.main.bounds.width - (spacing * 4)
        layout.itemSize = CGSize(width: width / 3, height: width / 2.5)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 40)
        return layout
    }
    
    
    override func configureView() {
        self.addSubview(headerView)
        self.addSubview(collectionView)
    }
    
    override func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        headerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}
