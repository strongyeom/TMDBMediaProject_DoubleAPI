//
//  ProfileView.swift
//  TMDBMediaProject_DoubleAPI
//
//  Created by 염성필 on 2023/08/29.
//

import UIKit

class ProfileView: BaseView {
    
    let topView = TopView()
    let downView = DownView()
    
    override func configureView() {
        self.addSubview(topView)
        self.addSubview(downView)
    }
    
    override func setConstraints() {
        
        topView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(self.safeAreaLayoutGuide).multipliedBy(0.3)
        }
        
        downView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(topView)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        topView.profileImage.layer.cornerRadius = self.topView.profileImage.frame.width / 2
        topView.profileImage.clipsToBounds = true
    }
}
