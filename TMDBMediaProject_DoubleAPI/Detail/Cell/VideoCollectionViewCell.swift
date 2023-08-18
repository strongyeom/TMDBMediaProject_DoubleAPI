//
//  VideoCollectionViewCell.swift
//  TMDBMediaProject_DoubleAPI
//
//  Created by 염성필 on 2023/08/19.
//

import UIKit

class VideoCollectionViewCell: UICollectionViewCell {

    @IBOutlet var thumbnailImage: UIImageView!
    
    @IBOutlet var thumbnailTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        thumbnailImage.backgroundColor = .yellow
        thumbnailTitle.font = .systemFont(ofSize: 50, weight: .heavy)
        thumbnailTitle.textColor = .blue
        thumbnailTitle.numberOfLines = 0
    }

}
