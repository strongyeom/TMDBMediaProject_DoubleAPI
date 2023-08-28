//
//  AllpreTVCell.swift
//  TMDBMediaProject_DoubleAPI
//
//  Created by 염성필 on 2023/08/28.
//

import UIKit

class AllpreTVCell : BaseTableViewCell {
    
    let detailImageView = {
       let image = UIImageView()
        image.contentMode = .scaleToFill
        image.backgroundColor = .red
        return image
    }()
    
    let titleLabel = {
       let label = UILabel()
        label.textColor = .green
        label.numberOfLines = 0
        return label
    }()
    
    override func configureView() {
        contentView.addSubview(detailImageView)
        contentView.addSubview(titleLabel)
    }
    
    override func setConstraints() {
        detailImageView.snp.makeConstraints { make in
            //make.verticalEdges.equalToSuperview().inset(10)
            make.leading.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
            make.size.equalTo(self.snp.height).multipliedBy(0.8)
        }
 
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(detailImageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
        }
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
       // detailImageView.frame.width = self.frame.width
      
    }
}
