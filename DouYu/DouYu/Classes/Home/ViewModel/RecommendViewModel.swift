//
//  RecommendViewModel.swift
//  DouYu
//
//  Created by 曹林 on 2018/7/13.
//  Copyright © 2018年 曹林. All rights reserved.
//

import UIKit

class RecommendViewModel {
    lazy var anchorGroups: [AnchorGroup] = [AnchorGroup]()
    private lazy var bigDataGroup: AnchorGroup = AnchorGroup()
    private lazy var prettyGroup: AnchorGroup = AnchorGroup()
}

// MARK: - 发送网络请求
extension RecommendViewModel {
    func requestData(finishCallback: @escaping ()-> ()) {
        let parameters = ["limit": "4", "offset": "0", "time": Date.getCurrentTime()]
        let dGroup = DispatchGroup()
        //1.0 请求推荐数据
        dGroup .enter()
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time": Date.getCurrentTime()]) { (result) in
            guard let resultDict = result as? [String : Any] else {
                return;
            }
            guard let dataArray = resultDict["data"] as? [[String: Any]] else {
                return;
            }
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            for dict in dataArray {
                let anchors = AnchorModel(dict: dict);
                self.bigDataGroup.anchors.append(anchors)
            }
            dGroup.leave()
        }
        //2.0 请求颜值数据
        dGroup.enter()
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (result) in
            debugPrint(result)
            guard let resultDict = result as? [String : Any] else {
                return;
            }
            guard let dataArray = resultDict["data"] as? [[String : Any]]  else {
                return;
            }
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict);
                self.prettyGroup.anchors.append(anchor)
            }
            dGroup.leave()
        }
        //3.0 请求后面的游戏数据
        dGroup.enter()
        NetworkTools .requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) { (result) in
            guard let resultDict = result as? [String : Any] else {
                return;
            }
            guard let dataArray = resultDict["data"] as? [[String : Any]]  else {
                return;
            }
            for dict in dataArray {
                let group = AnchorGroup(dict: dict)
                self.anchorGroups.append(group)
            }
            dGroup.leave()
        }
        //6.0 所有的数据请求到开始排序
        dGroup.notify(queue: DispatchQueue.main) {
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            finishCallback()
        }
    }
}

