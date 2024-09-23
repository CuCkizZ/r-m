//
//  UILabelConfigure.swift
//  RickAndMorty
//
//  Created by Nikita Beglov on 23.09.2024.
//

import UIKit.UILabel

extension UILabel {
    func configureInfoLabel() {
        textColor = .black
        textAlignment = .center
        font = UIFont.systemFont(ofSize: 24)
    }
    
    func configureConstantLabel() {
        textColor = .lightGray
        textAlignment = .center
        font = UIFont.systemFont(ofSize: 14)
    }
    
}
