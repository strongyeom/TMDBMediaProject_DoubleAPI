//
//  SearchViewController.swift
//  TMDBMediaProject_DoubleAPI
//
//  Created by 염성필 on 2023/08/30.
//

import UIKit
import Kingfisher

class SearchViewController: BaseViewController {
    
    
    let searchView = SearchView()
    
    var unsplashList: Unsplash = Unsplash(total: 0, totalPages: 0, results: [])
    
    var page: Int = 1
    
    // 클로저로 값 전달
    var completionHandler: ((URL) -> Void)?
    
    // protocol 값 전달
    var delegate: SelectedImage?
    
    // default 값 설정
    var searchText: String = "sky"
    
    override func loadView() {
        self.view = searchView
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func configureView() {
        super.configureView()
        settup()
        setNetworking(searchText: searchText, page: page)
    }
    
    func settup() {
        searchView.searchCollectionView.delegate = self
        searchView.searchCollectionView.dataSource = self
        searchView.searchCollectionView.prefetchDataSource = self
        searchView.searchBar.delegate = self
        searchView.searchBar.becomeFirstResponder()
    }
    
    func setNetworking(searchText: String, page: Int) {
        NetworkManager.shared.callRequstUnsplash(searchText: searchText, page: page) { response in
            guard let response else { return }
            self.unsplashList.results.append(contentsOf: response.results)
            self.searchView.searchCollectionView.reloadData()
        }
    }
}

extension SearchViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
        // 응답 메세지로 page에 대한 값이 정해져 있다면 조건을 추가해준다.
        // 또한 마지막 페이지가 나오면 더이상 page를 증가시키지 않는다.
        for indexPath in indexPaths {
            
            if unsplashList.results.count - 1 == indexPath.item && page < 1000 {
                page += 1
                setNetworking(searchText: searchText, page: page)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        print("===============")
    }
    
    
}


extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if unsplashList.results.count > 1 {
            return unsplashList.results.count
        } else {
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SearchCollectionViewCell.self), for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        let item = unsplashList.results[indexPath.item]
        cell.mainConfigure(item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selected = unsplashList.results[indexPath.item].urls.regular
        let url = URL(string: selected)!
        // completionHandler?(url)
        
       // delegate?.receiveImage(url: url)
        
        NotificationCenter.default.post(name: NSNotification.Name("SelectImage"), object: nil, userInfo: ["url": url])
        
        dismiss(animated: true)
    }
}


// MARK: - SearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text?.lowercased() {
            self.unsplashList.results.removeAll()
            setNetworking(searchText: text, page: page)
            searchText = text
        }
        self.searchView.searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchView.searchBar.text = ""
    }
}
