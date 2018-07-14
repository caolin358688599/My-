//
//  CollectionPrettyViewCell.swift
//  DouYu
//
//  Created by 曹林 on 2018/7/8.
//  Copyright © 2018年 曹林. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionPrettyViewCell: CollectionBaseCell {
    @IBOutlet weak var cityBtn: UIButton!
   override var anchor: AnchorModel? {
        didSet {
            super.anchor = anchor
            cityBtn.setTitle(anchor?.anchor_city, for: .normal)
        }
    }

}
