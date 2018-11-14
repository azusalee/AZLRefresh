//
//  AZLRefreshHeader.swift
//  ALExampleTest
//
//  Created by yangming on 2018/11/12.
//  Copyright © 2018年 Mac. All rights reserved.
//

import UIKit

public class AZLRefreshHeader: AZLRefreshView {
    
    //刷新事件的回調
    public var refreshBlock:(() -> Void)?
    
    //如果在添加refreshHeader后，再設置contentInset，需要手動設置originScrollTopInset
    public var originScrollTopInset:CGFloat = 0
    
    
    public class func createHeader(refresh:(() -> Void)?) -> AZLRefreshHeader {
        let header = self.init()
        header.refreshBlock = refresh
        
        return header
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
        
        self.originScrollTopInset = newScrollView.contentInset.top
        
        self.frame = CGRect.init(x: 0, y: -self.bounds.size.height-self.originScrollTopInset, width: newScrollView.bounds.size.width, height: self.bounds.size.height)
        self.autoresizingMask = [.flexibleWidth]
        
        newScrollView.insertSubview(self, at: 0)
        
        newScrollView.addObserver(self, forKeyPath: "contentOffset", options: [.new, .old], context: nil)
        
    }
    
    
    override public func beginRefresh() {
        super.beginRefresh()
        UIView.animate(withDuration: AZLRefreshAnimateTime) {
            self.scrollView?.azl_setContentInset(top: self.originScrollTopInset+self.bounds.size.height)
            self.scrollView?.contentOffset = CGPoint.init(x: 0, y: -(self.originScrollTopInset+self.bounds.size.height))
        }
        self.refreshBlock?()
    }
    
    override public func endRefresh() {
        super.endRefresh()
        UIView.animate(withDuration: AZLRefreshAnimateTime) {
            self.scrollView?.azl_setContentInset(top: self.originScrollTopInset)
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
                    //下拉的比例
                    let pullPercent:Double = Double(-(newValue.y+self.originScrollTopInset)/self.bounds.size.height)
                    self.updatePullPercent(percent: pullPercent)
                    if pullPercent >= 1 {
                        self.setRefreshStatus(state: .readyRefresh)
                    }else {
                        self.setRefreshStatus(state: .normal)
                    }
                }else{
                    if self.refreshState == .readyRefresh {
                        self.beginRefresh()
                    }
                }
            }
        }
    }
    
    override public func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        if let oldSuperView = self.superview {
            self.scrollView?.azl_setContentInset(top: self.originScrollTopInset)
            oldSuperView.removeObserver(self, forKeyPath: "contentOffset")
        }
    }
    
}
