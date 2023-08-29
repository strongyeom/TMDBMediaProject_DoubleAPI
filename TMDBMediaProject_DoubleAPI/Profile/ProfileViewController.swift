//
//  ProfileViewController.swift
//  TMDBMediaProject_DoubleAPI
//
//  Created by 염성필 on 2023/08/29.
//

import UIKit

protocol SettingNameProtocol {
    func reciveName(text: String)
}

enum ProfileSettingElements: String {
    case name = "이름"
    case userName = "사용자 이름"
    case profilePhoto = "프로필 사진"
    case avata = "아바타"

}

 class ProfileViewController: BaseViewController {
    
    private let profileView = ProfileView()
    
    private let profileElements: [String] = ["이름", "사용자 이름", "프로필 사진", "아바타"]
    
     var settingUserName: String?
    
     private let picker = UIImagePickerController()
    
    override func loadView() {
        self.view = profileView
    }

    override func configureView() {
        super.configureView()
        profileView.backgroundColor = .systemMint
        profileView.downView.userTalbeView.dataSource = self
        profileView.downView.userTalbeView.delegate = self
        
        profileView.downView.userTalbeView.register(DownTableViewCell.self, forCellReuseIdentifier: String(describing: DownTableViewCell.self))
        navigationItem.backButtonTitle = ""
        
        NotificationCenter.default.addObserver(self, selector: #selector(settingNotification), name: .selectedCell, object: nil)
         getPhotoGallery()
        
    }
    
    func getPhotoGallery() {
        
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else { return }
        picker.delegate = self
        
        picker.sourceType = .photoLibrary
        
    }
    
    @objc func settingNotification(notification: NSNotification) {
        if let name = notification.userInfo?["name"] as? String {
            profileView.topView.profileUserName.text = name
            settingUserName = name
            profileView.downView.userTalbeView.reloadData()
        }
    }

}

extension ProfileViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return profileElements.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DownTableViewCell.self), for: indexPath) as? DownTableViewCell else { return UITableViewCell() }
        
        if indexPath.section == 0 {
            cell.userInputTextLabel.text = profileElements[indexPath.row]
            
        } else {
            
            cell.userInputTextLabel.text = settingUserName ?? "임시 방편"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedCell = ProfileSettingElements(rawValue: profileElements[indexPath.item])
        
        if indexPath.section == 0 {
            switch selectedCell {
            case .name:
                let vc = SettingViewController()
                vc.profileSettingElements = selectedCell
                vc.delegate = self
//                vc.completionHandler = { text in
//                    print("안녕하세요")
//                    self.profileView.topView.profileTitle.text = text
//                }
                navigationController?.pushViewController(vc, animated: true)
            case .userName:
                let vc = SettingViewController()
                vc.profileSettingElements = selectedCell
                          
                navigationController?.pushViewController(vc, animated: true)
            case .profilePhoto:
                // 갤러리 띄우기
                present(picker, animated: true)
               
                print("123")
            case .avata:
                print("123")
            default:
                break
            }
        } else {
            
        }
        
    }

}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("취소 버튼이 눌렸습니다.")
        dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.profileView.topView.profileImage.image = image
            dismiss(animated: true)
        }
    }
}

extension ProfileViewController : SettingNameProtocol {
    func reciveName(text: String) {
        self.profileView.topView.profileTitle.text = text
    }
}
