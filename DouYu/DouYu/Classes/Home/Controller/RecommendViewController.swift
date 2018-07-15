//
//  RecommendViewController.swift
//  DouYu
//
//  Created by 曹林 on 2018/7/7.
//  Copyright © 2018年 曹林. All rights reserved.
//

import UIKit
   // MARK: - 定义常量
private let kItemMargin: CGFloat = 10
private let kHeaderViewH: CGFloat = 50
private let kNormalCellID = "kNormalCellID"
private let kHeaderViewID = "kHeaderViewID"
let kPrettyCellID = "kPrettyCellID"
let kNormalItemW = (kScreenW - 3 * kItemMargin ) / 2
let kNormalItemH = kNormalItemW * 3 / 4
let kPrettyItemH = kNormalItemW * 4 / 3
private let kCycleViewH = kScreenW * 3 / 8
private let kGameViewH: CGFloat = 90
class RecommendViewController: BaseViewController {
    private lazy var recommendVM:   RecommendViewModel = RecommendViewModel()
      // MARK: - 定义属性
    fileprivate lazy var cycleView: RecommendCycleView = {
        let cycleView = RecommendCycleView.recommendCycleView()
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewH + kGameViewH), width: kScreenW, height: kCycleViewH)
        return cycleView
    }()
    fileprivate lazy var gameView: RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
    }()
    
    lazy var collectionView: UICollectionView = { [unowned  self] in
        // 1.0 创建布局
        let layout = UICollectionViewFlowLayout()
       // layout.itemSize = CGSize(width: kNormalItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        // 2.0 创建UIColletionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.register(UINib(nibName: "CollectionViewNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
       collectionView.register(UINib(nibName: "CollectionPrettyViewCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        collectionView.register(UINib(nibName: "RecommendReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        collectionView.dataSource = self
       collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = UIColor.white
        return collectionView
        
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
 
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension RecommendViewController {
    func loadData () {
        recommendVM.requestData {
            self.collectionView.reloadData()
            self.gameView.groups = self.recommendVM.anchorGroups
        }
        recommendVM.requestCycleData {
            self.cycleView.cycleModels = self.recommendVM.cycleModels
        }
    }
}

extension RecommendViewController {
    func setupUI() {
        view.addSubview(collectionView)
        //2.0 将cycleView添加到UIcollectionionView中
        collectionView.addSubview(cycleView)
        gameView.backgroundColor = UIColor.red
        collectionView.addSubview(gameView)
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH + kGameViewH, left: 0, bottom: 0, right: 0)
        
    }
}

extension RecommendViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = recommendVM.anchorGroups[section];
        return group.anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kNormalItemW, height: kPrettyItemH)
        }
        return CGSize(width: kNormalItemW, height: kNormalItemH)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! RecommendReusableView
        let group = recommendVM.anchorGroups[indexPath.section];
        headerView.group = group
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let group = recommendVM.anchorGroups[indexPath.section];
        let anchor = group.anchors[indexPath.row];
        var cell: CollectionBaseCell!
        if indexPath.section == 1 {
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionPrettyViewCell
        } else {
          cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionViewNormalCell
        }
        cell.anchor = anchor
        return cell
    }
}

extension RecommendViewController: UICollectionViewDelegate {
    
}
