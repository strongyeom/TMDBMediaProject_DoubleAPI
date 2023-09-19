//
//  ViewController.swift
//  TMDBMediaProject_DoubleAPI
//
//  Created by 염성필 on 2023/08/18.
//

import UIKit
import SeSaCUIFramework

class MainViewController: UIViewController {
    
    @IBOutlet var tmdbCollectionView: UICollectionView!
    
    var movieList: Movie = Movie(page: 0, results: [], totalPages: 0, totalResults: 0)
    var page: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set(true, forKey: "isLanuched")
          configureSetting()
        tmdbCollectionView.delegate = self
        tmdbCollectionView.dataSource = self
        settingCollectionViewLayout()
        setupNetwork(page: page)
    }
    
    
    
    func configureSetting() {
     
      //  tmdbCollectionView.prefetchDataSource = self
        
        let nib = UINib(nibName: MovieCollectionViewCell.identifier, bundle: nil)
        tmdbCollectionView.register(nib, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        
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
        tmdbCollectionView.collectionViewLayout = layout
    }
    
    func setupNetwork(page: Int) {

        Network.shared.reqeust(type: Movie.self, api: .all(page: page)) { response in
            switch response {
            case .success(let success):
              //  print(success)
                self.movieList.results.append(contentsOf: success.results)
                print(self.movieList.results)
                self.tmdbCollectionView.reloadData()
            case .failure(let failure):
                print(failure.description)
            }
  
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

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        guard let vc = sb.instantiateViewController(withIdentifier: DetailViewController.identifier) as? DetailViewController else { return }
        let movie = movieList.results[indexPath.item]
        vc.detailMovie = movie
        navigationController?.pushViewController(vc, animated: true)
    }
}
