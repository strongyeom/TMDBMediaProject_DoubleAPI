//
//  DownView.swift
//  TMDBMediaProject_DoubleAPI
//
//  Created by 염성필 on 2023/08/29.
//

import UIKit

class DownView : BaseView {
    
    let userTalbeView = UITableView(frame: .zero, style: .insetGrouped)
    
    
    override func configureView() {
        self.addSubview(userTalbeView)
        userTalbeView.backgroundColor = .clear
        userTalbeView.isScrollEnabled = false
        userTalbeView.rowHeight = 60
    }
    
    override func setConstraints() {
        userTalbeView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
