//
//  VideoCollectionViewCell.swift
//  TMDBMediaProject_DoubleAPI
//
//  Created by 염성필 on 2023/08/19.
//

import UIKit

class VideoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var thumbnailImage: UIImageView!
    
    @IBOutlet var playBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        thumbnailImage.settingImageContendMode()
        configureBtnImageSize()
    }
    
    func configureBtnImageSize() {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 50, weight: .light)
        let image = UIImage(systemName: "play.circle", withConfiguration: imageConfig)
        playBtn.setTitle("", for: .normal)
        playBtn.setImage(image, for: .normal)
        playBtn.tintColor = .white
        playBtn.layer.cornerRadius = 27.5
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnailImage.image = nil
        
    }
    
    
    
}
