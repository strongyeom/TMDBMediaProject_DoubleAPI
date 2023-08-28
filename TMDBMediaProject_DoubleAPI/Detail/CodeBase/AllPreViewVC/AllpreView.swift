//
//  AllpreView.swift
//  TMDBMediaProject_DoubleAPI
//
//  Created by 염성필 on 2023/08/28.
//

import UIKit

class AllpreView : BaseView {
    
    let tableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.rowHeight = 100
        return table
    }()
    
    
    override func configureView() {
        self.addSubview(tableView)
    }
    
    override func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
