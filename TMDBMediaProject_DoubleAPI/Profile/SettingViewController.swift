//
//  SettingViewController.swift
//  TMDBMediaProject_DoubleAPI
//
//  Created by 염성필 on 2023/08/29.
//

import UIKit

class SettingViewController: BaseViewController {
    
    let settingView = SettingView()
    
    var completionHandler: ((String) -> Void)?
    
    override func loadView() {
        self.view = settingView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        settingView.reuseButton.button.addTarget(self, action: #selector(saveBtnClicked), for: .touchUpInside)
    }
    
    @objc func saveBtnClicked() {
        print("SettingViewController - saveBtnClicked")
        completionHandler?(settingView.reuseTopView.titleTextField.text!)
        dismiss(animated: true)
    }
    override func configureView() {
        super.configureView()
    }

}
