//
//  RecommendGameView.swift
//  DouYu
//
//  Created by 曹林 on 2018/7/15.
//  Copyright © 2018年 曹林. All rights reserved.
//

import UIKit

private let kGameCell = "gameCell"
class RecommendGameView: UIView {
    var groups: [AnchorGroup]? {
        didSet{
            groups?.removeFirst()
            groups?.removeFirst()
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            groups?.append(moreGroup)
            self.collectionView.reloadData()
        }
    }
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
     collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCell)
    }
}

extension RecommendGameView {
    class func recommendGameView() -> RecommendGameView {
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)! [0] as! RecommendGameView
    }
}

extension RecommendGameView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let grop = groups![indexPath.row]
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCell, for: indexPath) as! CollectionGameCell
        cell.group = grop
        return cell
    }
}
