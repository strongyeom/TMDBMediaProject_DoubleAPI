//
//  Ext+ UITextField.swift
//  TMDBMediaProject_DoubleAPI
//
//  Created by 염성필 on 2023/08/30.
//

import UIKit

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

