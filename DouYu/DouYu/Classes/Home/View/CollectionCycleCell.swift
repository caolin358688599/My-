//
//  CollectionCycleCell.swift
//  DouYu
//
//  Created by 曹林 on 2018/7/14.
//  Copyright © 2018年 曹林. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionCycleCell: UICollectionViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    var cycleModel: CycleModel? {
        didSet {
            titleLabel.text = cycleModel?.title
            let iconURL = URL(string: cycleModel?.pic_url ?? "")
             iconImageView.kf.setImage(with: iconURL)
//            iconImageView.kf.setImage(with: (iconURL as! Resource), placeholder: UIImage(named: "Img_default"))
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
