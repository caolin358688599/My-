//
//  CollectionGameCell.swift
//  DouYu
//
//  Created by 曹林 on 2018/7/15.
//  Copyright © 2018年 曹林. All rights reserved.
//

import UIKit

class CollectionGameCell: UICollectionViewCell {
    var group: AnchorGroup? {
        didSet {
            titleLabel.text = group?.tag_name
            if   let url = URL(string: group?.icon_url ?? "")  {
             iconImageView.kf.setImage(with: url)
            } else {
                iconImageView.image = UIImage(named: "home_more_btn")
            }
        }
    }
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
