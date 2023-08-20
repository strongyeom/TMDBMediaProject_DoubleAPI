//
//  FooterVideoCollectionReusableView.swift
//  TMDBMediaProject_DoubleAPI
//
//  Created by 염성필 on 2023/08/20.
//

import UIKit

class FooterVideoCollectionReusableView: UICollectionReusableView {

    @IBOutlet var addPreViewBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        addPreViewBtn.setTitle("더보기", for: .normal)
        self.addPreViewBtn.addTarget(self, action: #selector(addPreviewBtnClicked(_:)), for: .touchUpInside)
    }
    
    @objc
    func addPreviewBtnClicked(_ sender: UIButton) {
        print("더보기 버튼 눌림 ")
    }
}
