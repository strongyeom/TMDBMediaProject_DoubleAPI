//
//  MainCVCell.swift
//  TMDBMediaProject_DoubleAPI
//
//  Created by 염성필 on 2023/08/28.
//

import UIKit

class MainCVCell : BaseCollectionViewCell {
    
    let imageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        return image
    }()
    
    let titleLabel = {
       let label = UILabel()
        return label
    }()
    
    
    
    override func configureView() {
        contentView.addSubview(imageView)
        imageView.addSubview(titleLabel)
        imageView.settingImageCorner()
        imageView.settingImageContendMode()
        titleLabel.settingMoveTitle()
    }
    
    override func setConstraints() {
        imageView.backgroundColor = .yellow
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(10)
        }
    }
}
