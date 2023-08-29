//
//  SettingViewController.swift
//  TMDBMediaProject_DoubleAPI
//
//  Created by 염성필 on 2023/08/29.
//

import UIKit

extension NSNotification.Name {
    static let selectedCell = NSNotification.Name("SelectedCell")
}
class SettingViewController: BaseViewController {
    
    let settingView = SettingView()
    
    var profileSettingElements: ProfileSettingElements?
    
    var completionHandler: ((String) -> Void)?
    
    override func loadView() {
        self.view = settingView
    }
    
    override func configureView() {
        super.configureView()
        settingView.reuseButton.button.addTarget(self, action: #selector(saveBtnClicked), for: .touchUpInside)
        // navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(dismissBtnClicked))
        guard let value = profileSettingElements?.rawValue else { return }
        switch value {
        case "이름":
            print("이름")
            settingView.reuseTopView.titleTextField.placeholder = "\(value) 입력하세요"
        case "사용자 이름":
            print("사용자 이름")
            settingView.reuseTopView.titleTextField.placeholder = "\(value) 입력하세요"
        case "프로필 사진":
            print("프로필 사진")
        case "아바타":
            print("아바타")
        default:
            break
        }
        
    }
    
    @objc func dismissBtnClicked() {
        print("취소 버튼 눌림")
        
    }
    
    @objc func saveBtnClicked() {
        print("SettingViewController - saveBtnClicked")
        
        if profileSettingElements?.rawValue == "이름" {
            completionHandler?(settingView.reuseTopView.titleTextField.text!)
        } else {
            NotificationCenter.default.post(name: .selectedCell, object: nil, userInfo: ["name":settingView.reuseTopView.titleTextField.text!])
        }
        navigationController?.popViewController(animated: true)
        
       
    }

}
