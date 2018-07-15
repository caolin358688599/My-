//
//  CycleModel.swift
//  DouYu
//
//  Created by 曹林 on 2018/7/14.
//  Copyright © 2018年 曹林. All rights reserved.
//

import UIKit

@objcMembers  class CycleModel: NSObject {
    var title: String?
    var pic_url: String?
    var room: [String: Any]? {
        didSet {
            guard let room = room else {
                return
            }
            anchor = AnchorModel(dict: room)
        }
    }
    var anchor: AnchorModel?
    init(dict: [String: Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }

}
