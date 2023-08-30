//
//  ReuseTextFieldView.swift
//  TMDBMediaProject_DoubleAPI
//
//  Created by 염성필 on 2023/08/29.
//

import UIKit

class ReuseTopView: BaseView {
    
    let reuseView = UIView()
    
    let titleTextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1
        textField.placeholder = "제목을 입력해주세요"
        textField.textAlignment = .left
        textField.font = .boldSystemFont(ofSize: 15)
        textField.addLeftPadding()
        return textField
    }()
    
    
    override func configureView() {
        self.addSubview(reuseView)
        reuseView.addSubview(titleTextField)
    }
    
    override func setConstraints() {
        reuseView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).inset(50)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.height.equalTo(60)
        }
    }
}

