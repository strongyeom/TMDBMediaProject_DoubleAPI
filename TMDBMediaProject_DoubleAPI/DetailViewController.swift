//
//  DetailViewController.swift
//  TMDBMediaProject_DoubleAPI
//
//  Created by 염성필 on 2023/08/18.
//

import UIKit

class DetailViewController: UIViewController {
    
    var detailMovie: MovieResult?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "영화 상세 정보"
        print("detailMovie",detailMovie!)
    }
}
