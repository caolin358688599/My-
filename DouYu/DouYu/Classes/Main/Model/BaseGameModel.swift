//
//  BaseGameModel.swift
//  DouYu
//
//  Created by 曹林 on 2018/7/9.
//  Copyright © 2018年 曹林. All rights reserved.
//

import UIKit

class BaseGameModel: NSObject {
       // MARK: - 自定义属性
    var tag_name: String?
    var icon_url: String?

    init(dict: [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
}
