//
//  TopView.swift
//  TMDBMediaProject_DoubleAPI
//
//  Created by 염성필 on 2023/08/29.
//

import UIKit

class TopView: BaseView {
    
    let bgView = UIView()
    
    let profileImage = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.layer.borderColor = UIColor.white.cgColor
        image.layer.borderWidth = 3
        
        return image
    }()
    
    let profileTitle = {
        let label = UILabel()
        label.text = "염성필"
        label.font = .systemFont(ofSize: 13, weight: .medium)
        return label
    }()
    
    let profileUserName = {
        let label = UILabel()
        label.text = "yeom_sungpil"
        label.font = .systemFont(ofSize: 12, weight: .light)
        return label
    }()
    
    lazy var stackView = {
        let stack = UIStackView(arrangedSubviews: [profileTitle, profileUserName])
        stack.axis = .vertical
        stack.spacing = 3
        stack.alignment = .center
        stack.distribution = .fill
        return stack
    }()
    
    
    override func configureView() {
        
        self.addSubview(bgView)
        [profileImage, stackView].forEach {
            bgView.addSubview($0)
        }
        bgView.backgroundColor = .clear
        profileImage.backgroundColor = .yellow
    }
    
    override func setConstraints() {
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        profileImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(100)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            
        }
        
        
    }
}
