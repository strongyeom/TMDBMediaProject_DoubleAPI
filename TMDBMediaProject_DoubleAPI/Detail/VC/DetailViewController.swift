//
//  DetailViewController.swift
//  TMDBMediaProject_DoubleAPI
//
//  Created by 염성필 on 2023/08/18.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    
    var detailMovie: MovieResult?
    var detailMovieCast: MovieCast?
    var detailMovieVideo: MovieVideo?
    
    @IBOutlet var detailMovieTitleLabel: UILabel!
    @IBOutlet var movieBackImage: UIImageView!
    @IBOutlet var detailPosterImage: UIImageView!
    
    @IBOutlet var overviewLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    @IBOutlet var toggleBtn: NSLayoutConstraint!
    
    @IBOutlet var castTableView: UITableView!
    @IBOutlet var videoCollectionView: UICollectionView!
    
    
    
    var numberOfLines: Int = 1
    let thumbnailUrl = "https://img.youtube.com/vi/"
    let thumbnailSize = "/maxresdefault.jpg"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "영화 상세 정보"
        setup()
        configureTableSetting()
        configureCollectionSetting()
        settingCollectionViewLayout()
        setupNetworkCast()
        
        
        
    }
    
    func setupNetworkCast() {
        guard let detailMovie else { return }
        NetworkManager.shared.callRequestCast(id: detailMovie.id) { castResponse, videoResponse in
            self.detailMovieCast = castResponse
            self.detailMovieVideo = videoResponse
            print("detailMovieCast",self.detailMovieCast!)
            self.castTableView.reloadData()
            self.videoCollectionView.reloadData()
            self.castTableView.setContentOffset(.init(x: .zero, y: 200), animated: true)
        }
    }
    
    
//    func setupNetworkVideo() {
//        guard let detailMovie else { return }
//        NetworkManager.shared.callRequestVideo(id: detailMovie.id) { response in
//            self.detailMovieVideo = response
//            print("detailMovieCast",self.detailMovieVideo!)
//            self.videoCollectionView.reloadData()
//            self.castTableView.reloadData()
//        }
//    }
//
    
    
    @IBAction func toggleBtnClicked(_ sender: UIButton) {
        print("버튼이 눌렸음")
        
        if numberOfLines == 1 {
            descriptionLabel.numberOfLines = 0
            numberOfLines = 0
            sender.isSelected = true
        } else if numberOfLines == 0  {
            descriptionLabel.numberOfLines = 1
            numberOfLines = 1
            sender.isSelected = false
        }
    }
}


// MARK: - TableView + Extension
extension DetailViewController : UITableViewDelegate {

}

extension DetailViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let detailMovieCast else { return 0 }
        return detailMovieCast.cast.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCastTableViewCell.identifier, for: indexPath) as? MovieCastTableViewCell else { return UITableViewCell() }
        guard let detailMovieCast else { return UITableViewCell() }
        let row = detailMovieCast.cast[indexPath.row]
        cell.configure(row: row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Cast"
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(#function)
        // 테이블 뷰의 contentOfset.y = contentViewHeight - scrollviewHeight 즉, 스크롤 한 거리
        let yOffset = scrollView.contentOffset.y
            print("yOffset", yOffset)
                if yOffset > 0 {
                    print("테이블 뷰 스크롤 진행됨")
                    castTableView.setContentOffset(.init(x: .zero, y: yOffset), animated: true)
                    
                }
    }
    
}


// MARK: - Collectionview + Extension
extension DetailViewController : UICollectionViewDelegate {
    // paging 하면 중앙 정렬하게 맞추기
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        guard let layout = self.videoCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        
        let estimatedIndex = scrollView.contentOffset.x / cellWidthIncludingSpacing
        let index: Int
        if velocity.x > 0 {
            index = Int(ceil(estimatedIndex))
        } else if velocity.x < 0 {
            index = Int(floor(estimatedIndex))
        } else {
            index = Int(round(estimatedIndex))
        }
        
        targetContentOffset.pointee = CGPoint(x: CGFloat(index) * cellWidthIncludingSpacing, y: 0)
    }
}

extension DetailViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let detailMovieVideo else { return 0 }
        let previewCount = detailMovieVideo.results.count
        
        if previewCount < 4 {
            return detailMovieVideo.results.count
        } else {
            return 5
        }
        
        // return 5
    }
    
    // 유툽 썸네일 : https://img.youtube.com/vi/qoaVM9WdfMI/maxresdefault.jpg
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let detailMovieVideo else { return  UICollectionViewCell() }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCollectionViewCell.identifier, for: indexPath) as? VideoCollectionViewCell else { return UICollectionViewCell() }
        print("indexPath.item", indexPath.item)
            let item = detailMovieVideo.results[indexPath.item]

        guard let url = URL(string: thumbnailUrl + item.key + thumbnailSize) else { return UICollectionViewCell() }
            cell.thumbnailImage.kf.setImage(with: url)
        cell.playBtn.tag = indexPath.item
        cell.playBtn.addTarget(self, action: #selector(playBtnClicked(_:)), for: .touchUpInside)
        return cell
    }
    
    @objc func playBtnClicked(_ sender: UIButton)  {
        print("플레이 버튼이 눌렸다 \(sender.tag)")
        guard let detailMovieVideo else { return }
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        guard let vc = sb.instantiateViewController(withIdentifier: WebViewController.identifier) as? WebViewController else { return }
        let youtubeBaseUrl = "https://www.youtube.com/watch?v="
        let selectedBtnKey = youtubeBaseUrl + detailMovieVideo.results[sender.tag].key
        print("selectedBtnKey",selectedBtnKey)
        vc.imageKey = selectedBtnKey
        present(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FooterVideoCollectionReusableView.identifier, for: indexPath) as? FooterVideoCollectionReusableView else { return UICollectionReusableView() }
            footer.addPreViewBtn.addTarget(self, action: #selector(addpreviewBtnClicked(_:)), for: .touchUpInside)
            return footer
        } else {
            return UICollectionReusableView()
        }
    }
    
    @objc func addpreviewBtnClicked(_ sender: UIButton) {
        print("예고편 더보기 버튼이 눌림")
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        guard let vc = sb.instantiateViewController(withIdentifier: AllPreViewViewController.identifier) as? AllPreViewViewController else { return }
        guard let detailMovieVideo else { return }
        vc.movieId = detailMovieVideo.id
       // let nav = UINavigationController(rootViewController: vc)
        
        navigationController?.pushViewController(vc, animated: true)
    }
}


// MARK: - DetailViewController + Extension
extension DetailViewController {
    
    func setup() {
        let backUrl = URL(string: Movie.baseImageurl + detailMovie!.backdropPath)!
        detailMovieTitleLabel.text = detailMovie?.title
        detailMovieTitleLabel.settingDetailMovieTitle()
        
        movieBackImage.kf.setImage(with: backUrl)
        movieBackImage.settingImageContendMode()
        
        overviewLabel.text = "overview"
        overviewLabel.textColor = .lightGray
        overviewLabel.font = UIFont.systemFont(ofSize: 20)
        
        descriptionLabel.text = detailMovie?.overview
         descriptionLabel.numberOfLines = numberOfLines
        let posterUrl = URL(string: Movie.baseImageurl + detailMovie!.posterPath)
        detailPosterImage.kf.setImage(with: posterUrl)
        detailPosterImage.settingImageContendMode()
    }
    
    func configureTableSetting() {
        castTableView.dataSource = self
        castTableView.delegate = self
        castTableView.rowHeight = 120
        let nib = UINib(nibName: MovieCastTableViewCell.identifier, bundle: nil)
        castTableView.register(nib, forCellReuseIdentifier: MovieCastTableViewCell.identifier)
    }
    
    func configureCollectionSetting() {
        videoCollectionView.dataSource = self
        videoCollectionView.delegate = self
        let nib = UINib(nibName: VideoCollectionViewCell.identifier, bundle: nil)
        videoCollectionView.register(nib, forCellWithReuseIdentifier: VideoCollectionViewCell.identifier)
        videoCollectionView.decelerationRate = .fast
        
        videoCollectionView.isPagingEnabled = false
        
        let headernib = UINib(nibName: FooterVideoCollectionReusableView.identifier, bundle: nil)
        videoCollectionView.register(headernib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: FooterVideoCollectionReusableView.identifier)
        
    }
    
    // paging 처리 하기위해서 spaing 값 없앴음
    func settingCollectionViewLayout() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let width = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: width, height: 300)
        layout.footerReferenceSize = CGSize(width: 100, height: 50)
        videoCollectionView.collectionViewLayout = layout
    }
}

