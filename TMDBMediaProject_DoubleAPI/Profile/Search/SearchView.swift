//
//  SearchView.swift
//  TMDBMediaProject_DoubleAPI
//
//  Created by 염성필 on 2023/08/30.
//

import UIKit

class SearchView: BaseView {
    
    let searchBar = {
        let search = UISearchBar()
        search.placeholder = "검색어를 입력하세요"
        search.showsCancelButton = true
        return search
    }()
    
    lazy var searchCollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: settingCollectionFlowLayout())
        collection.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: SearchCollectionViewCell.self))
        return collection
    }()
    
    func settingCollectionFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let spacing: CGFloat = 10
        let width = UIScreen.main.bounds.width - (spacing * 4)
        layout.itemSize = CGSize(width: width / 3, height: width / 3)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        return layout
    }

    
    override func configureView() {
        self.addSubview(searchBar)
        self.addSubview(searchCollectionView)
    }
    
    override func setConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(50)
        }
        
        searchCollectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        
//        
//    }
}
