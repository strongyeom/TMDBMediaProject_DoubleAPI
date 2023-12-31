//
//  CodeMainViewController.swift
//  TMDBMediaProject_DoubleAPI
//
//  Created by 염성필 on 2023/08/28.
//

import UIKit

class CodeMainViewController: BaseViewController {
    
    let mainVC = MainVC()
    
    var movieList: Movie = Movie(page: 0, results: [], totalPages: 0, totalResults: 0)
    var page: Int = 1
    
    
    override func loadView() {
        self.view = mainVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    func setupNetwork(page: Int) {
        
//
//        NetworkManager.shared.callRequest(page: page) { response in
//
//            switch response {
//            case .success(let success):
//                self.movieList.results.append(contentsOf: success.results)
//                self.mainVC.collectionView.reloadData()
//            case .failure(let failure):
//                print(failure.description)
//            }
//        }
        
        Network.shared.reqeust(type: Movie.self, api: .all(page: page)) { response in
            switch response {
            case .success(let success):
                self.movieList.results.append(contentsOf: success.results)
                self.mainVC.collectionView.reloadData()
            case .failure(let failure):
                print(failure.description)
            }
        }
        
    }
    
    override func configureView() {
        super.configureView()
        print("여기가 제대로 타나요?")
        UserDefaults.standard.set(true, forKey: "isLanuched")
        
        settup()
        setupNetwork(page: page)
        settingNavigationBar()
    }
    
    func settingNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .yellow
        // 네비게이션 분리도 주기 ( isTranslucent : 투명도 )
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    func settup() {
        mainVC.collectionView.dataSource = self
        mainVC.collectionView.delegate = self
        mainVC.collectionView.prefetchDataSource = self
    }
    
}

extension CodeMainViewController : UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        print("UICollectionViewDataSourcePrefetching")
        
        // 응답 메세지로 page에 대한 값이 정해져 있다면 조건을 추가해준다.
        // 또한 마지막 페이지가 나오면 더이상 page를 증가시키지 않는다.
        for indexPath in indexPaths {
            
            if movieList.results.count - 1 == indexPath.row && page < 1000 {
                page += 1
                setupNetwork(page: page)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        print("====== 취소 되었다\(indexPaths) ============")
    }
    
    
}


extension CodeMainViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if movieList.results.count > 1 {
            //  print("갯수", movieList.results.count)
            return movieList.results.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MainCVCell.self), for: indexPath) as? MainCVCell else { return UICollectionViewCell() }
        
        let item = movieList.results[indexPath.item]
        if movieList.results.count > 2 {
            cell.confiure(item: item)
        }
        
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
