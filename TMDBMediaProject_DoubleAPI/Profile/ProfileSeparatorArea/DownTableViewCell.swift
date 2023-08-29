//
//  DownTableViewCell.swift
//  TMDBMediaProject_DoubleAPI
//
//  Created by 염성필 on 2023/08/29.
//

import UIKit

class DownTableViewCell : BaseTableViewCell {
    
    let userInputTextLabel = {
       let label = UILabel()
        label.text = "ㅇㄴㅇㅁㅇㅇㄴ"
        return label
    }()
    override func configureView() {
        self.addSubview(userInputTextLabel)
        self.accessoryType = .disclosureIndicator
        self.selectionStyle = .none
    }
    
   override func setConstraints() {
        userInputTextLabel.snp.makeConstraints { make in
            make.leading.verticalEdges.equalToSuperview().inset(10)
        }
    }
}
