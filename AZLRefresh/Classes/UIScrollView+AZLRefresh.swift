//
//  UIScrollView+AZLRefresh.swift
//  ALExampleTest
//
//  Created by yangming on 2018/11/12.
//  Copyright © 2018年 Mac. All rights reserved.
//

import UIKit

let AZLRefreshHeaderTag = 3000
let AZLRefreshFooterTag = 4000

public extension UIScrollView {
    
    //添加头部刷新
    public func azl_addHeaderRefresh(refreshHeader:AZLRefreshHeader) {
        self.azl_removeHeaderRefresh()
        refreshHeader.tag = AZLRefreshHeaderTag
        refreshHeader.addToScrollView(newScrollView: self)
    }
    
    //移除头部刷新
    public func azl_removeHeaderRefresh() {
        if let refreshView = self.viewWithTag(AZLRefreshHeaderTag) {
            refreshView.removeFromSuperview()
        }
    }
    
    //获取头部刷新
    public func azl_refreshHeader() -> AZLRefreshHeader? {
        if let refreshView = self.viewWithTag(AZLRefreshHeaderTag) as? AZLRefreshHeader {
            return refreshView
        }
        return nil
    }
    
    
    //添加底部刷新
    public func azl_addFooterRefresh(footerRefresh:AZLRefreshFooter) {
        self.azl_removeFooterRefresh()
        footerRefresh.tag = AZLRefreshFooterTag
        footerRefresh.addToScrollView(newScrollView: self)
    }
    
    //移除底部刷新
    public func azl_removeFooterRefresh() {
        if let refreshView = self.viewWithTag(AZLRefreshFooterTag) {
            refreshView.removeFromSuperview()
        }
    }
    
    //获取底部刷新
    public func azl_refreshfooter() -> AZLRefreshFooter? {
        if let refreshView = self.viewWithTag(AZLRefreshFooterTag) as? AZLRefreshFooter {
            return refreshView
        }
        return nil
    }
}


//添加简易的方法，方便调用
extension UIScrollView {
    
    func azl_setContentInset(top:CGFloat) {
        let inset = self.contentInset
        self.contentInset = UIEdgeInsets.init(top: top, left: inset.left, bottom: inset.bottom, right: inset.right)
    }
    
    func azl_setContentInset(left:CGFloat) {
        let inset = self.contentInset
        self.contentInset = UIEdgeInsets.init(top: inset.top, left: left, bottom: inset.bottom, right: inset.right)
    }
    
    func azl_setContentInset(bottom:CGFloat) {
        let inset = self.contentInset
        self.contentInset = UIEdgeInsets.init(top: inset.top, left: inset.left, bottom: bottom, right: inset.right)
    }
    
    func azl_setContentInset(right:CGFloat) {
        let inset = self.contentInset
        self.contentInset = UIEdgeInsets.init(top: inset.top, left: inset.left, bottom: inset.bottom, right: right)
    }
    
}
