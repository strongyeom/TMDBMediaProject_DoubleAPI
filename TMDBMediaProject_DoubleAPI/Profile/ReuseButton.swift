//
//  ReuseButton.swift
//  TMDBMediaProject_DoubleAPI
//
//  Created by 염성필 on 2023/08/29.
//

import UIKit

class ReuseButton : BaseView {
    
    let view = UIView()
    let button = {
       let button = UIButton()
        button.setTitle("저장", for: .normal)
        button.backgroundColor = .blue
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        return button
    }()
    
    override func configureView() {
        self.addSubview(view)
        self.addSubview(button)
        view.backgroundColor = .red
    }
    
    override func setConstraints() {
        view.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(1)
        }
        
        button.snp.makeConstraints { make in
            make.top.equalTo(view.snp.bottom).offset(9)
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(20)
            make.horizontalEdges.equalToSuperview().inset(10)
        }
    }
}
