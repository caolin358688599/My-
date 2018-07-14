//
//  AnchorModel.swift
//  DouYu
//
//  Created by 曹林 on 2018/7/9.
//  Copyright © 2018年 曹林. All rights reserved.
//

import UIKit

@objcMembers class AnchorModel: NSObject {
       // MARK: - 定义属性
    //房间ID
    var room_id: Int = 0
    //房间图片对应的URL
    var vertical_src: String?
    // 0 电脑直播 1 手机直播
    var isVertiacl: Int = 0
    //房间名称
    var room_name: String?
    //主播昵称
    var nickname: String?
    //在线人数
    var online: Int = 0
    //所在城市
    var anchor_city: String?
    
    init(dict: [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
 
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
}
