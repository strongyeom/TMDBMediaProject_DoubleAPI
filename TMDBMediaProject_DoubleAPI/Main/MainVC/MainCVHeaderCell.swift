//
//  MainCVHeaderCell.swift
//  TMDBMediaProject_DoubleAPI
//
//  Created by 염성필 on 2023/08/28.
//

import UIKit
import SnapKit

class MainCVHeaderCell : UICollectionReusableView {
    
    let label = UILabel()
    let label1 = UILabel()
    let label2 = UILabel()
    let label3 = UILabel()
    let label4 = UILabel()
    
    
    lazy var stackView = {
        let stack = UIStackView(arrangedSubviews: [label,label1,label2,label3,label4])
        stack.axis = .horizontal
        stack.spacing = 10
        stack.alignment = .fill
        stack.distribution = .fillEqually
        return stack
    }()

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        addSubview(stackView)
        self.backgroundColor = .red
        label.backgroundColor = .green
        label1.backgroundColor = .systemMint
        label2.backgroundColor = .brown
        label3.backgroundColor = .orange
        label4.backgroundColor = .blue
    }
    
    func setConstraints() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            print("make.edges.equalToSuperview()",make.edges.equalToSuperview())
        }
    }
}
