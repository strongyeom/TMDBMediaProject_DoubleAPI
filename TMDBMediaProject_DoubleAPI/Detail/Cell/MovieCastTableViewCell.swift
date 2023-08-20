//
//  MovieCastTableViewCell.swift
//  TMDBMediaProject_DoubleAPI
//
//  Created by 염성필 on 2023/08/18.
//

import UIKit
import Kingfisher

class MovieCastTableViewCell: UITableViewCell {

    @IBOutlet var actorImage: UIImageView!
    
    @IBOutlet var actorName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        actorName.font = UIFont.systemFont(ofSize: 15)
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configure(row: Cast) {
        
        actorName.text = row.name
        settingImageIndicator(url: row.profilePath ?? "")
        
    }
    
    func settingImageIndicator(url: String) {
        let url = URL(string: MovieCast.imageUrl + url)
        let processor = DownsamplingImageProcessor(size: actorImage.bounds.size)
                     |> RoundCornerImageProcessor(cornerRadius: 20)
        actorImage.kf.indicatorType = .activity
        actorImage.kf.setImage(
            with: url,
            placeholder: UIImage(named: "placeholderImage"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        actorImage.image = nil
        actorName.text = nil
    }
    
}
