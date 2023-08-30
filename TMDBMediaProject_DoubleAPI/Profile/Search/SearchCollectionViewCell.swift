//
//  SearchCollectionViewCell.swift
//  TMDBMediaProject_DoubleAPI
//
//  Created by 염성필 on 2023/08/30.
//

import UIKit

class SearchCollectionViewCell: BaseCollectionViewCell {
    
    let indicator = {
       let indi = UIActivityIndicatorView()
        indi.style = .medium
        indi.tintColor = .red
        return indi
    }()
    
    let imageView = {
       let image = UIImageView()
        image.contentMode = .scaleToFill
        return image
    }()
    
    
    override func configureView() {
        contentView.addSubview(imageView)
        imageView.addSubview(indicator)
        indicator.startAnimating()
    }
    
    override func setConstraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        indicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func mainConfigure(_ item: UnSplashResult) {
        let url = URL(string: item.urls.regular)!
        self.imageView.kf.setImage(with: url) { _ in
            self.indicator.stopAnimating()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.layer.cornerRadius = self.frame.width / 2
        imageView.clipsToBounds = true
    }
}
