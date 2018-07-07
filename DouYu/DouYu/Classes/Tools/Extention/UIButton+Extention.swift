//
//  UIButton+Extention.swift
//  DouYu
//
//  Created by 曹林 on 2018/7/7.
//  Copyright © 2018年 曹林. All rights reserved.
//

import UIKit

// MARK: - 设置普通图片，高亮图片
extension UIButton {
 convenience init(imageNormal: String, highlightedImage: String, backgroundImage: UIImage?, backgroundHightlightedImage: UIImage, target: Any?,action: Selector) {
    self.init()
    self.setImage(UIImage(named: imageNormal), for: .normal)
    self.setImage(UIImage(named: highlightedImage), for: .highlighted)
    self.setBackgroundImage(backgroundImage, for: .normal)
    self.setBackgroundImage(backgroundHightlightedImage, for: .highlighted)
    self.addTarget(target, action: action, for: .touchUpInside)
    self.sizeToFit()
    }
}
