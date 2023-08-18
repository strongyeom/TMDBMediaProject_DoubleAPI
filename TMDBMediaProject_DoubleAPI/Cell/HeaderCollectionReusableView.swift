//
//  HeaderCollectionReusableView.swift
//  TMDBMediaProject_DoubleAPI
//
//  Created by 염성필 on 2023/08/18.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
    
    @IBOutlet var myPickMovieLabel: UILabel!
    
    @IBOutlet var filterLabel: UILabel!
    
    @IBOutlet var filterPulBtn: UIButton!
    
    @IBOutlet var watchedDate: UILabel!
    
    @IBOutlet var watchedDatePulBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure() {
        self.myPickMovieLabel.text = "내가 픽한 영화"
        self.filterLabel.text = "Filter"
        self.filterPulBtn.setImage(UIImage(systemName: "flame"), for: .normal)
        self.watchedDate.text = "감상일"
        self.watchedDatePulBtn.setImage(UIImage(systemName: "book"), for: .normal)
    }
    
}
