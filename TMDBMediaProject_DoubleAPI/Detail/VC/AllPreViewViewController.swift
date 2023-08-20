//
//  AllPreViewViewController.swift
//  TMDBMediaProject_DoubleAPI
//
//  Created by 염성필 on 2023/08/20.
//

import UIKit
import Kingfisher

class AllPreViewViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var movieVideo: MovieVideo?
    var movieId: Int?
    let thumbnailUrl = "https://img.youtube.com/vi/"
    let thumbnailSize = "/maxresdefault.jpg"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        settupNetwork()
    }
    
    func settupNetwork() {
        guard let movieId else { return }
        NetworkManager.shared.callRequestVideo(id: movieId) { response in
            self.movieVideo = response
            self.tableView.reloadData()
        }
    }
    
    func setup() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 150
        let nib = UINib(nibName: PreViewTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: PreViewTableViewCell.identifier)
    }

}

extension AllPreViewViewController: UITableViewDelegate {
    
}

extension AllPreViewViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let movieVideo else { return 0 }
        return movieVideo.results.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PreViewTableViewCell.identifier, for: indexPath) as? PreViewTableViewCell else { return UITableViewCell() }
        guard let movieVideo else { return UITableViewCell() }
        let row = movieVideo.results[indexPath.row]
        let url = URL(string: thumbnailUrl + row.key + thumbnailSize)!
        cell.previewThumbnail.kf.setImage(with:  url)
        cell.previewTitle.text = row.name
        return cell
    }
    
}
