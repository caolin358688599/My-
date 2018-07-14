//
//  RecommendReusableView.swift
//  DouYu
//
//  Created by 曹林 on 2018/7/8.
//  Copyright © 2018年 曹林. All rights reserved.
//

import UIKit

class RecommendReusableView: UICollectionReusableView {
     // MARK: - 控件属性
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
       // MARK: - 定义模型属性
    var group: AnchorGroup? {
        didSet {
            titleLabel.text = group?.tag_name
            iconImageView.image = UIImage(named: group?.icon_name ?? "")
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
