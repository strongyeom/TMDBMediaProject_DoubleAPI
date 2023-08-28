//
//  CodeAllPreViewController.swift
//  TMDBMediaProject_DoubleAPI
//
//  Created by 염성필 on 2023/08/28.
//

import UIKit

class CodeAllPreViewController: BaseViewController {
    
    let allpreView = AllpreView()
    
    override func loadView() {
        self.view = allpreView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func configureView() {
        super.configureView()
        allpreView.tableView.dataSource = self
        allpreView.tableView.delegate = self
        
        allpreView.tableView.register(AllpreTVCell.self, forCellReuseIdentifier: String(describing: AllpreTVCell.self))
    }
}

extension CodeAllPreViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AllpreTVCell.self), for: indexPath) as? AllpreTVCell else { return UITableViewCell() }
        // let row = list[indexPath.row]
        cell.titleLabel.text = "가이드 라인 입니다."
        return cell
    }
}
