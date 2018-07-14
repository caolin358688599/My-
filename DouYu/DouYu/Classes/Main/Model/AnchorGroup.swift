//
//  AnchorGroup.swift
//  DouYu
//
//  Created by 曹林 on 2018/7/9.
//  Copyright © 2018年 曹林. All rights reserved.
//

import UIKit

@objcMembers class AnchorGroup: NSObject {
    //
    var icon_name: String = "home_header_normal"
     lazy var anchors: [AnchorModel] = [AnchorModel]()
    //该组中对应的房间信息
    var room_list: [[String : Any]]?  {
        didSet {
            guard let room_list = room_list else {
                return;
            }
            for dict in room_list {
                anchors.append(AnchorModel(dict: dict))
            }
            
        }
    }
    // 组显示的标题
    var tag_name: String?
    
    init(dict: [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    override init() {
        
    }
//    lazy var anchors: [AnchorModel] = [AnchorModel]()
    
//    var room_list: [[String : Any]]? {
//        didSet {
//            guard let room_list = room_list else {
//                return
//            }
//            for dict in room_list {
//                anchors.append(AnchorModel(dict: dict))
//            }
//        }
//    }
    
}
