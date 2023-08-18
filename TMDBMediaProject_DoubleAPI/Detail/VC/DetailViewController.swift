//
//  DetailViewController.swift
//  TMDBMediaProject_DoubleAPI
//
//  Created by 염성필 on 2023/08/18.
//

import UIKit

class DetailViewController: UIViewController {
    
    var detailMovie: MovieResult?
    var detailMovieCast: MovieCast?
    
    @IBOutlet var detailMovieTitleLabel: UILabel!
    @IBOutlet var movieBackImage: UIImageView!
    @IBOutlet var detailPosterImage: UIImageView!
    
    @IBOutlet var overviewLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    @IBOutlet var toggleBtn: NSLayoutConstraint!
    
    @IBOutlet var castTableView: UITableView!
    
    @IBOutlet var videoCollectionView: UICollectionView!
    
    
    
    var numberOfLines: Int = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "영화 상세 정보"
        setup()
        configureSetting()
        setupNetwork()
        
    }
    
    func setupNetwork() {
        guard let detailMovie else { return }
        NetworkManager.shared.callRequestCast(id: detailMovie.id) { response in
            self.detailMovieCast = response
            print("detailMovieCast",self.detailMovieCast)
            self.castTableView.reloadData()
        }
    }
    
    @IBAction func toggleBtnClicked(_ sender: UIButton) {
        print("버튼이 눌렸음")
        if numberOfLines == 1 {
            descriptionLabel.numberOfLines = 0
            numberOfLines = 0
        } else if numberOfLines == 0  {
            descriptionLabel.numberOfLines = 1
            numberOfLines = 1
        }
    }
}

extension DetailViewController : UITableViewDelegate {
    
}

extension DetailViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let detailMovieCast else { return 0 }
        return detailMovieCast.cast.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = castTableView.dequeueReusableCell(withIdentifier: MovieCastTableViewCell.identifier, for: indexPath) as? MovieCastTableViewCell else { return UITableViewCell() }
        guard let detailMovieCast else { return UITableViewCell() }
        let row = detailMovieCast.cast[indexPath.row]
        cell.configure(row: row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Cast"
    }
}

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
    
    func configureSetting() {
        castTableView.dataSource = self
        castTableView.delegate = self
        castTableView.rowHeight = 120
        let nib = UINib(nibName: MovieCastTableViewCell.identifier, bundle: nil)
        castTableView.register(nib, forCellReuseIdentifier: MovieCastTableViewCell.identifier)
    }
}
