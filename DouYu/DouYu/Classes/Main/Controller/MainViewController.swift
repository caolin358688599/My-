//
//  MainViewController.swift
//  DouYu
//
//  Created by 曹林 on 2018/7/1.
//  Copyright © 2018年 曹林. All rights reserved.
//

import UIKit

class MainViewController:    UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置子控制器
        setupChildViewController()
        UITabBar.appearance().tintColor = UIColor.orange
    }
}
extension MainViewController {
    private func setupChildViewController() {
        let array = [
            ["claName": "HomeViewController", "title": "首页", "image": "btn_home_"],
            ["claName": "LiveViewController", "title": "直播", "image": "btn_column_"],
            ["claName": "FollowViewController", "title": "关注", "image": "btn_live_"],
            ["claName": "ProfileViewController", "title": "我的", "image": "btn_user_"],
        ]
        var arrayM = [UIViewController]()
        for dict in array {
            arrayM.append(controller(dict: dict))
        }
        viewControllers = arrayM
    }
    private func controller(dict: [String:String])-> UIViewController  {
        guard  let claName = dict["claName"],
                    let title = dict["title"],
                    let image = dict["image"],
                    let cla = NSClassFromString(Bundle.main.namespace + "." + claName) as? UIViewController.Type
        else {
                return UIViewController()
        }
        let vc = cla.init()
        vc.title = title
        vc.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.orange], for: .highlighted)
        vc.tabBarItem.image = UIImage(named: image + "normal")
        vc.tabBarItem.selectedImage = UIImage(named: image + "selected")
        let nav = BaseNavViewController(rootViewController: vc)
        return nav
    }
}
