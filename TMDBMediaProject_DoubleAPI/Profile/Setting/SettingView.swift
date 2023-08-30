//
//  SettingView.swift
//  TMDBMediaProject_DoubleAPI
//
//  Created by 염성필 on 2023/08/29.
//

import UIKit

class SettingView : BaseView {
    
    let reuseTopView = ReuseTopView()
    let reuseButton = ReuseButton()
    
    
    override func configureView() {
        self.addSubview(reuseTopView)
        self.addSubview(reuseButton)
    }
    
    override func setConstraints() {
   
        
        reuseTopView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(reuseButton.snp.top)
            
        }
        
        
        reuseButton.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
            make.height.equalTo(self.safeAreaLayoutGuide).multipliedBy(0.1)
        }
    }
}
