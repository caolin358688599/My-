//
//  PageTitleView.swift
//  DouYu
//
//  Created by 曹林 on 2018/7/7.
//  Copyright © 2018年 曹林. All rights reserved.
//

import UIKit
   // MARK: - 定义协议
protocol PageTitleViewDelegate: class  {
     func pageTitleView(_ titleView: PageTitleView, selectedIndex index: Int)
}
// MARK: -  定义常量
private let kScrollLineH: CGFloat = 2
private let kNormalColor: (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let kSelectColor: (CGFloat, CGFloat, CGFloat) = (255, 128, 0)
   // MARK: - 定义PageTitleView类
class PageTitleView: UIView {
       // MARK: - 定义属性
    /// 当前index
    fileprivate var currentIndex: Int = 0
    fileprivate var titles: [String]
    weak var delegate: PageTitleViewDelegate?
   // MARK: - 懒加载属性
    fileprivate lazy var titleLabels: [UILabel] = [UILabel]()
    fileprivate lazy var scrollView: UIScrollView = {
        let scrollview = UIScrollView()
        scrollview.showsVerticalScrollIndicator = false
        scrollview.scrollsToTop = false
        scrollview.bounces = false
        return scrollview
    }()
    fileprivate lazy var scrollLine: UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    // MARK: - 自定义构造函数
    /// pageTitleview 构造函数
    ///
    /// - Parameters:
    ///   - frame: frame
    ///   - titles: 标题数组
    init(frame: CGRect, titles:[String]) {
        self.titles = titles
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension PageTitleView {
    fileprivate func setupUI() {
       // 1.0 添加UIScrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        // 2.0 添加title对应的Label
        setupTitleLabels()
        //3.0 添加底线和滚动的滑块
        setupBottomLineAndScrollLine()
    }
    
    fileprivate func setupTitleLabels() {
        let labelW: CGFloat = frame.width / CGFloat(titles.count)
        let labelH: CGFloat  = frame.height - kScrollLineH
        let labelY: CGFloat = 0
        for (index, title) in titles.enumerated() {
            let label = UILabel()
            label.text = title
            label.tag = index
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            let labelX : CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            scrollView.addSubview(label)
            titleLabels.append(label)
            label.isUserInteractionEnabled = true
            let tagGes = UITapGestureRecognizer(target: self, action: #selector(titleLabelClick(_:)))
            label.addGestureRecognizer(tagGes)
        }
    }
    
    fileprivate func setupBottomLineAndScrollLine() {
        // 1.0 添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH: CGFloat = 1.0
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        // 2.0 添加scrollLine
        // 2.1 获取第一个label
        guard let firstLabel = titleLabels.first else {
            return
        }
        
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
        
    }
}

// MARK: - 监听Label的点击
extension PageTitleView {
    @objc fileprivate func titleLabelClick(_ tapGes: UITapGestureRecognizer) {
        // 0 获取当前label
        guard let  currentLabel = tapGes.view as? UILabel else {
            return
        }
        //1.0 如果是重复点击同一个Title，直接返回
        if currentLabel.tag == currentIndex {
            return
        }
        //2.0 获取之前的label
       let oldLabel = titleLabels[currentIndex]
        //3.0 切换文字的颜色
        currentLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        // 4.0 保存最新Label的下标value
        currentIndex = currentLabel.tag
        //5.0 滚动条位置发生改变
        let scrollLineX = CGFloat(currentIndex) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
        //6.0 通知代理
        delegate?.pageTitleView(self, selectedIndex: currentIndex)
    }
}
extension PageTitleView {
    func setTitleWithProgrss(_ progrss: CGFloat, souceIndex: Int, targetIndex: Int){
        // 1. 取出souceLabel/TargetLabel
        let sourceLabel = titleLabels[souceIndex]
        let targetLabel = titleLabels[targetIndex]
        // 2.0 处理滑块的逻辑
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progrss
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        // 3.0 颜色的渐变
        // 3.1.取出变化的范围
        let colorDelta = (kSelectColor.0 - kNormalColor.0, kSelectColor.1 - kNormalColor.1, kSelectColor.2 - kNormalColor.2)
          // 3.2.变化sourceLabel
        sourceLabel.textColor = UIColor(r: kSelectColor.0 - colorDelta.0 * progrss, g: kSelectColor.1 - colorDelta .1 * progrss, b: kSelectColor.2 - colorDelta.2 * progrss)
           // 3.2.变化targetLabel
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progrss, g: kNormalColor.1 + colorDelta.1 * progrss, b: kNormalColor.2 * colorDelta.2 * progrss)
        currentIndex = targetIndex
    }
}
