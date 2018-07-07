//
//  UIBarButtonItem+Extention.swift
//  DouYu
//
//  Created by 曹林 on 2018/7/7.
//  Copyright © 2018年 曹林. All rights reserved.
//

import UIKit
   // MARK: - 自定义UIBarButtonItem
extension UIBarButtonItem {
    /// 便利构造函数
    ///
    /// - Parameters:
    ///   - imageName: 普通图片名称
    ///   - hightImageName: 高亮图片名称
    ///   - size: 大小
    convenience init(imageName: String, hightImageName: String = "", size: CGSize = CGSize.zero) {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName
        ), for: .normal)
        if  hightImageName != "" {
            btn.setImage(UIImage(named: hightImageName), for: .highlighted)
        }
        if size ==  CGSize.zero {
            btn.sizeToFit()
        } else {
             btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        self.init(customView: btn)
    }
}
