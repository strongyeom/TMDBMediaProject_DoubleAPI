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
        settup()
        settupNavigationBar()
        settupNotificationCenter()
     
    }
     
     func settupNotificationCenter() {
         NotificationCenter.default.addObserver(self, selector: #selector(settingNotification(notification:)), name: .selectedCell, object: nil)
          getPhotoGallery()
         
         NotificationCenter.default.addObserver(self, selector: #selector(settingImageNotification(notification: )), name: .selectedImage, object: nil)
     }
     
     @objc func settingNotification(notification: NSNotification) {
         if let text = notification.userInfo?["name"] as? String {
             self.profileView.topView.profileUserName.text = text
             settingUserName = text
             self.profileView.downView.userTalbeView.reloadData()
         }
     }
     
     @objc func settingImageNotification(notification: NSNotification) {
         if let url = notification.userInfo?["url"] as? URL {
             self.profileView.topView.profileImage.kf.setImage(with: url)
         }
     }
     
     
     func settupNavigationBar() {
         navigationItem.backButtonTitle = ""
         navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Search", style: .plain, target: self, action: #selector(searchBtnClicked(_:)))
         
         let appearance = UINavigationBarAppearance()
         appearance.backgroundColor = .orange
         navigationController?.navigationBar.standardAppearance = appearance
         navigationController?.navigationBar.scrollEdgeAppearance = appearance
     }
     
     
     
     @objc func searchBtnClicked(_ sender: UIBarButtonItem) {
         print("Search 버튼 눌림")
         let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
         let gallery = UIAlertAction(title: "갤러리에서 가져오기", style: .default) { _ in
             print("갤러리 버튼 눌림")
             // 갤러리에서 가져오기
             self.present(self.picker, animated: true)
         }
         let webImage = UIAlertAction(title: "웹에서 가져오기", style: .default) { _ in
             print("웹 버튼 눌림")
             let vc = SearchViewController()
//             vc.completionHandler = { url in
//                 self.profileView.topView.profileImage.kf.setImage(with: url)
//             }
             
           //  vc.delegate = self
             self.present(vc, animated: true)
         }
         let cancel = UIAlertAction(title: "취소", style: .cancel)
         
         actionSheet.addAction(gallery)
         actionSheet.addAction(webImage)
         actionSheet.addAction(cancel)
         present(actionSheet, animated: true)
     }
     
     func settup() {
         profileView.backgroundColor = .systemMint
         profileView.downView.userTalbeView.dataSource = self
         profileView.downView.userTalbeView.delegate = self
         
         profileView.downView.userTalbeView.register(DownTableViewCell.self, forCellReuseIdentifier: String(describing: DownTableViewCell.self))
     }
    
    func getPhotoGallery() {
        
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else { return }
        picker.delegate = self
        
        picker.sourceType = .photoLibrary
        
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

//extension ProfileViewController : SelectedImage {
//    func receiveImage(url: URL) {
//        self.profileView.topView.profileImage.kf.setImage(with: url)
//    }
//}
