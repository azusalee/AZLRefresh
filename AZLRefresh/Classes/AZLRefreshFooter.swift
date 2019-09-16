//
//  AZLRefreshFooter.swift
//  ALExampleTest
//
//  Created by lizihong on 2018/11/12.
//  Copyright © 2018年 Mac. All rights reserved.
//

import UIKit

public class AZLRefreshFooter: AZLRefreshView {

    //刷新事件的回調
    public var refreshBlock:(() -> Void)?
    
    //如果在添加refreshFooter后，再設置contentInset，需要手動設置originScrollBottomInset
    public var originScrollBottomInset:CGFloat = 0
    
    //如果設置為true，那麼滑到底端的時候就會刷新（也就是不用上拉再松开）
    public var isAutoRefresh = false
    
    
    public class func createFooter(refresh:(() -> Void)?) -> AZLRefreshFooter {
        
        let footer = self.init()
        footer.refreshBlock = refresh
        
        return footer
    }
    
    override init(frame: CGRect) {
        var newFrame = frame
        if newFrame.size.height == 0 {
            newFrame.size.height = AZLRefreshDefaultHeight
        }
        super.init(frame: newFrame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public func addToScrollView(newScrollView:UIScrollView) {
        super.addToScrollView(newScrollView: newScrollView)
        
        self.originScrollBottomInset = newScrollView.contentInset.bottom
        
        let contentSizeHeight = self.scrollView?.contentSize.height ?? 0
        var targetOriginY = contentSizeHeight+self.originScrollBottomInset
        let boundsSizeHeight = self.scrollView?.bounds.size.height ?? 0
        if targetOriginY < boundsSizeHeight {
            targetOriginY = boundsSizeHeight
        }
        
        self.frame = CGRect.init(x: 0, y: targetOriginY, width: newScrollView.bounds.size.width, height: self.bounds.size.height)
        self.autoresizingMask = [.flexibleWidth]
        
        newScrollView.insertSubview(self, at: 0)
        
        newScrollView.addObserver(self, forKeyPath: "contentOffset", options: [.new, .old], context: nil)
        newScrollView.addObserver(self, forKeyPath: "contentSize", options: [.new, .old], context: nil)
        
    }
    
    override public func beginRefresh() {
        super.beginRefresh()
        let contentSizeHeight = self.scrollView?.contentSize.height ?? 0
        let boundsSizeHeight = self.scrollView?.bounds.size.height ?? 0
        var targetOriginY = contentSizeHeight+self.originScrollBottomInset
        var spaceInset:CGFloat = 0
        if targetOriginY < boundsSizeHeight {
            targetOriginY = boundsSizeHeight
            spaceInset = boundsSizeHeight-contentSizeHeight
        }
        UIView.animate(withDuration: AZLRefreshAnimateTime) {
            self.scrollView?.azl_setContentInset(bottom: self.originScrollBottomInset+self.bounds.size.height+spaceInset)
            self.scrollView?.contentOffset = CGPoint.init(x: 0, y: (targetOriginY+self.bounds.size.height-boundsSizeHeight))
        }
        self.refreshBlock?()
    }
    
    override public func endRefresh() {
        super.endRefresh()
        UIView.animate(withDuration: AZLRefreshAnimateTime) {
            self.scrollView?.azl_setContentInset(bottom: self.originScrollBottomInset)
        }
    }
    
    
    override public func updateRefreshState(state: AZLRefreshState) {
        super.updateRefreshState(state: state)
        
    }
    
    override public func updatePullPercent(percent: Double) {
        super.updatePullPercent(percent: percent)
    }
    
    override public func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "contentOffset" {
            if let newValue:CGPoint = change?[NSKeyValueChangeKey.newKey] as? CGPoint {
                
                if self.isHidden == true {
                    return
                }
                
                if self.refreshState == .refreshing {
                    return
                }
                
                if self.refreshState == .noMoreData {
                    return
                }
                
                if self.bounds.size.height <= 0 {
                    return
                }
                
                
                if self.scrollView?.isDragging == true {
                    //上拉的比例
                    let contentSizeHeight = self.scrollView?.contentSize.height ?? 0
                    let boundsSizeHeight = self.scrollView?.bounds.size.height ?? 0
                    var targetOriginY = contentSizeHeight+self.originScrollBottomInset
                    if targetOriginY < boundsSizeHeight {
                        targetOriginY = boundsSizeHeight
                    }
                    let pullPercent:Double = Double((newValue.y+boundsSizeHeight-targetOriginY)/self.bounds.size.height)
                    self.updatePullPercent(percent: pullPercent)
                    if self.isAutoRefresh == true {
                        if pullPercent >= 0 {
                            self.beginRefresh()
                        }
                    }else{
                        if pullPercent >= 1 {
                            self.setRefreshStatus(state: .readyRefresh)
                        }else {
                            self.setRefreshStatus(state: .normal)
                        }
                    }
                    
                    
                }else{
                    if self.refreshState == .readyRefresh {
                        self.beginRefresh()
                    }
                }
            }
        }else if keyPath == "contentSize" {
            if let contentSize:CGSize = change?[NSKeyValueChangeKey.newKey] as? CGSize {
                
                var targetOriginY = contentSize.height+self.originScrollBottomInset
                let boundsSizeHeight = self.scrollView?.bounds.size.height ?? 0
                if targetOriginY < boundsSizeHeight {
                    targetOriginY = boundsSizeHeight
                }
                
                self.frame = CGRect.init(x: 0, y: targetOriginY, width: self.bounds.size.width, height: self.bounds.size.height)
            }
        }
    }
    
    override public func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        if let oldSuperView = self.superview {
            self.scrollView?.azl_setContentInset(bottom: self.originScrollBottomInset)
            oldSuperView.removeObserver(self, forKeyPath: "contentOffset")
            oldSuperView.removeObserver(self, forKeyPath: "contentSize")
        }
    }
    

}
