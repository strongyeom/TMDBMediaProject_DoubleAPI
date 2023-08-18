//
//  ReuseIdentifierProtocol.swift
//  TMDBMediaProject_DoubleAPI
//
//  Created by 염성필 on 2023/08/18.
//

import UIKit

protocol ReuseIdentifierProtocol {
    static var identifier: String { get }
}

protocol CollectionViewAttributeProtocol {
    func configureSetting()
    func settingCollectionViewLayout()
}

extension UIViewController: ReuseIdentifierProtocol {
    
    static var identifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell : ReuseIdentifierProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}

extension HeaderCollectionReusableView : ReuseIdentifierProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}
