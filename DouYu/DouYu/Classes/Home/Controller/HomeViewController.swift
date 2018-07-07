//
//  HomeViewController.swift
//  DouYu
//
//  Created by 曹林 on 2018/7/7.
//  Copyright © 2018年 曹林. All rights reserved.
//

import UIKit
private let KTitleViewH: CGFloat = 40
class HomeViewController: BaseViewController {
       // MARK: - 懒加载属性
    fileprivate lazy var pageTitleView: PageTitleView = { [weak self] in
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: KTitleViewH)
        let titles = ["推荐", "游戏", "娱乐","趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        return titleView
    }()
    fileprivate lazy var pageContentView: PageContentView = { [weak self ] in
        // 1.0 确定内容到frame
        let contentH = kScreenH - kStatusBarH - kNavigationBarH - KTitleViewH - kTabbarH
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + KTitleViewH, width: kScreenW, height: contentH)
        var childVcs = [UIViewController]()
        childVcs.append(RecommendViewController())
        childVcs.append(GameViewController())
        childVcs.append(AmuseViewController())
        childVcs.append(FunnyViewController())
        let contentView = PageContentView(frame: contentFrame, childVCs: childVcs, parentViewController: self)
        contentView.delegate = self
        return contentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension HomeViewController {
    fileprivate func setupUI() {
        //view.backgroundColor = UIColor.groupTableViewBackground
        //0 .不需要调整UIScrollView内边距
        automaticallyAdjustsScrollViewInsets = false
        // 1.0 设置导航栏
        setupNavigationBar()
        //2.0 添加TitleView
        view.addSubview(pageTitleView)
        // 3.0 添加ContentView
        view.addSubview(pageContentView)
    }
    
    fileprivate func setupNavigationBar() {
        //1.0 设置左侧的Item
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        //2.0 设置右侧的Item
        let size = CGSize(width: 40, height: 40)
        let historyItem = UIBarButtonItem(imageName: "image_my_history", hightImageName: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(imageName: "btn_search", hightImageName: "btn_search_clicked", size: size)
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", hightImageName: "Image_scan_click", size: size)
        navigationItem.rightBarButtonItems = [historyItem, searchItem, qrcodeItem]
    }
}

extension HomeViewController: PageTitleViewDelegate {
    func pageTitleView(_ titleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCuttentIndex(index)
    }
}
extension  HomeViewController: PageContentViewDelegate {
    func pageContentView(_ contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgrss(progress, souceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
