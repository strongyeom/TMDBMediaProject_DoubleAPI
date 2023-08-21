//
//  ViewController.swift
//  TMDBMediaProject_DoubleAPI
//
//  Created by 염성필 on 2023/08/18.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet var tmdbCollectionView: UICollectionView!
    
    var movieList: Movie = Movie(page: 0, results: [], totalPages: 0, totalResults: 0)
    var page: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSetting()
        settingCollectionViewLayout()
        setupNetwork(page: page)
    }
    
    func setupNetwork(page: Int) {
        NetworkManager.shared.callRequest(page: page) { response in
            guard let response else { return }
            self.movieList.results.append(contentsOf: response.results)
            self.tmdbCollectionView.reloadData()
        }
    }
    
}

extension MainViewController: UICollectionViewDelegate {
    
}

extension MainViewController: UICollectionViewDataSourcePrefetching {
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

extension MainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       // guard let movieList else { return 0 }
        return movieList.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell() }
        let item = movieList.results[indexPath.item]
        cell.confiure(item: item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderCollectionReusableView.identifier, for: indexPath) as? HeaderCollectionReusableView else { return UICollectionReusableView() }
            header.configure()
            return header
        } else {
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        guard let vc = sb.instantiateViewController(withIdentifier: DetailViewController.identifier) as? DetailViewController else { return }
        let movie = movieList.results[indexPath.item]
        vc.detailMovie = movie
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension MainViewController: CollectionViewAttributeProtocol {

    func configureSetting() {
        tmdbCollectionView.delegate = self
        tmdbCollectionView.dataSource = self
        tmdbCollectionView.prefetchDataSource = self
        
        let nib = UINib(nibName: MovieCollectionViewCell.identifier, bundle: nil)
        tmdbCollectionView.register(nib, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)

        let headerNib = UINib(nibName: HeaderCollectionReusableView.identifier, bundle: nil)
        tmdbCollectionView.register(headerNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier)
    }
    
    func settingCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let spacing: CGFloat = 5
        let width = UIScreen.main.bounds.width - (spacing * 4)
        layout.itemSize = CGSize(width: width / 3, height: width / 2.5)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 40)
        tmdbCollectionView.collectionViewLayout = layout
    }


}
