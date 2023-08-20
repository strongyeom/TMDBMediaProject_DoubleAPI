//
//  PreViewTableViewCell.swift
//  TMDBMediaProject_DoubleAPI
//
//  Created by 염성필 on 2023/08/20.
//

import UIKit

class PreViewTableViewCell: UITableViewCell {

    @IBOutlet var previewThumbnail: UIImageView!
    
    @IBOutlet var previewTitle: UILabel!
    
    @IBOutlet var playTitme: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        previewThumbnail.settingImageContendMode()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        previewThumbnail.image = nil
    }
}
