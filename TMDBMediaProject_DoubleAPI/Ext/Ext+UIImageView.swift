//
//  Ext+UIImage.swift
//  TMDBMediaProject_DoubleAPI
//
//  Created by 염성필 on 2023/08/18.
//

import UIKit

extension UIImageView {
    func settingImageCorner() {
        self.layer.cornerRadius = 12
        self.clipsToBounds = true
    }
    
    func settingImageContendMode() {
        self.contentMode = .scaleToFill
    }
}
