//
//  WebViewController.swift
//  TMDBMediaProject_DoubleAPI
//
//  Created by 염성필 on 2023/08/20.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    @IBOutlet var webViewGroup: WKWebView!
    
    var imageKey: String?
    
    /** life cycle */
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let imageKey else { return }
        let url = URL(string: imageKey )
        let request = URLRequest(url: url!)

        self.webViewGroup.load(request)
    }
}

