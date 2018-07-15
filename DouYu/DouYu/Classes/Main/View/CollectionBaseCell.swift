//
//  CollectionBaseCell.swift
//  DouYu
//
//  Created by 曹林 on 2018/7/14.
//  Copyright © 2018年 曹林. All rights reserved.
//

import UIKit

class CollectionBaseCell: UICollectionViewCell {
       // MARK: - 定义控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var roomLabel: UILabel!
    @IBOutlet weak var onLineButton: UIButton!
    var anchor: AnchorModel? {
        didSet {
            guard  let anchor = anchor else {
                return;
            }
            var onlineStr: String = ""
            if anchor.online >= 1_0000 {
                onlineStr = "\(Int(anchor.online / 1_0000))万在线"
            } else {
                onlineStr = "\(anchor.online)在线"
            }
            onLineButton.setTitle(onlineStr, for: .normal)
            guard let iconURL = URL(string: anchor.vertical_src ?? "") else {
                return
            }
           // iconImageView.kf.setImage(with: iconURL)
            iconImageView.kf.setImage(with: iconURL)
        }
    }
}
