//
//  CodeMainViewController.swift
//  TMDBMediaProject_DoubleAPI
//
//  Created by 염성필 on 2023/08/28.
//

import UIKit

class CodeMainViewController: BaseViewController {
    
    let mainVC = MainVC()
    
    override func loadView() {
        self.view = mainVC
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("여기가 제대로 타나요?")
        UserDefaults.standard.set(true, forKey: "isLanuched")
        title = "여미의 상영관"
    }
    
    override func configureView() {
        super.configureView()
        
        mainVC.collectionView.dataSource = self
        mainVC.collectionView.delegate = self
    }

}
extension CodeMainViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MainCVCell.self), for: indexPath) as? MainCVCell else { return UICollectionViewCell() }
        cell.titleLabel.text = "여기는 영화 제목"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: MainCVHeaderCell.self), for: indexPath) as? MainCVHeaderCell else { return UICollectionReusableView() }
            header.label.text = "123"
            header.label1.text = "456"
            header.label2.text = "545"
            header.label3.text = "asds"
            header.label4.text = "!32321"
            return header
        } else {
            return UICollectionReusableView()
        }
    }
}
