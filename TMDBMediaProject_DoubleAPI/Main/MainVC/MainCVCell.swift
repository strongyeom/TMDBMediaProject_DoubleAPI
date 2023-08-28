//
//  MainCVCell.swift
//  TMDBMediaProject_DoubleAPI
//
//  Created by 염성필 on 2023/08/28.
//

import UIKit
import Kingfisher

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
    
    let indicator  = {
        let indi = UIActivityIndicatorView()
        indi.color = .red
        indi.style = .large
        return indi
    }()
    
   
    override func configureView() {
        contentView.addSubview(imageView)
        imageView.addSubview(titleLabel)
        contentView.addSubview(indicator)
        imageView.settingImageCorner()
        imageView.settingImageContendMode()
        titleLabel.settingMoveTitle()
        indicator.startAnimating()
    }
    
    override func setConstraints() {
       // imageView.backgroundColor = .yellow
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(10)
        }
        indicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

    }
    
    func confiure(item: MovieResult) {
       // settingImageIndicator(url: item.posterPath)
        self.titleLabel.text = item.title
        
        let url = URL(string: Movie.baseImageurl + item.posterPath)
        imageView.kf.setImage(with: url) { _ in
            self.indicator.stopAnimating()
        }
       
    }

    override func prepareForReuse() {
        super.prepareForReuse()
       imageView.image = nil
    }
}
