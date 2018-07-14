//
//  CollectionViewNormalCell.swift
//  DouYu
//
//  Created by 曹林 on 2018/7/8.
//  Copyright © 2018年 曹林. All rights reserved.
//

import UIKit

class CollectionViewNormalCell: CollectionBaseCell {
    
  override  var anchor : AnchorModel? {
        didSet {
           super.anchor = anchor
            roomLabel.text = anchor?.room_name
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
