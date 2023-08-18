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
    
    @IBOutlet var detailMovieTitleLabel: UILabel!
    @IBOutlet var movieBackImage: UIImageView!
    @IBOutlet var detailPosterImage: UIImageView!
    
    @IBOutlet var overviewLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    var numberOfLines: Int = 1
    @IBOutlet var toggleBtn: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "영화 상세 정보"
        print("detailMovie",detailMovie!)
        setup()
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
}
