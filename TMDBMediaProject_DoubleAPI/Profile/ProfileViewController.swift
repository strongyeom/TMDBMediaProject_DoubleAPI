//
//  ProfileViewController.swift
//  TMDBMediaProject_DoubleAPI
//
//  Created by 염성필 on 2023/08/29.
//

import UIKit

class ProfileViewController: BaseViewController {
    
    let profileView = ProfileView()
    
    let profileElements: [String] = ["이름", "사용자 이름", "프로필 사진", "아바타"]
    
    override func loadView() {
        self.view = profileView
    }

    override func configureView() {
        super.configureView()
        profileView.backgroundColor = .systemMint
        profileView.downView.userTalbeView.dataSource = self
        profileView.downView.userTalbeView.delegate = self
        
        profileView.downView.userTalbeView.register(DownTableViewCell.self, forCellReuseIdentifier: String(describing: DownTableViewCell.self))
    }
    
    override func setConstraints() {
        
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
            cell.userInputTextLabel.text = "일단 임시 방편"
        }
        
        return cell
    }

}
