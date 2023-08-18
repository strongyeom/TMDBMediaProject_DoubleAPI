//
//  MovieCollectionViewCell.swift
//  TMDBMediaProject_DoubleAPI
//
//  Created by 염성필 on 2023/08/18.
//

import UIKit
import Kingfisher

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var moviePoster: UIImageView!
    @IBOutlet var movieTitle: UILabel!
    
 
    override func awakeFromNib() {
        super.awakeFromNib()
        movieTitle.settingMoveTitle()
        moviePoster.settingImageCorner()
        moviePoster.settingImageContendMode()
    }
    
    func confiure(item: MovieResult) {
        settingImageIndicator(url: item.posterPath)
        self.movieTitle.text = item.title
    }
    
    func settingImageIndicator(url: String) {
        let url = URL(string: Movie.baseImageurl + url)
        let processor = DownsamplingImageProcessor(size: moviePoster.bounds.size)
                     |> RoundCornerImageProcessor(cornerRadius: 20)
        moviePoster.kf.indicatorType = .activity
        moviePoster.kf.setImage(
            with: url,
            placeholder: UIImage(named: "placeholderImage"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
    }
    
    // 재사용 될때 기존 데이터 지워줌
    override func prepareForReuse() {
        super.prepareForReuse()
        moviePoster.image = nil
    }

}
