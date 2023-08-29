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

// TextField 왼쪽에 Padding 주는 방법
extension UITextField {
  func addLeftPadding() {
      // 가로 10 세로 텍스트필드의 높이만큼
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
    // 왼쪽 View에 만들어준 paddingView 할당
    self.leftView = paddingView
      // 항상 보여지끔 설정
    self.leftViewMode = ViewMode.always
  }
}
