//
//  AZLRefreshView.swift
//  ALExampleTest
//
//  Created by yangming on 2018/11/12.
//  Copyright © 2018年 Mac. All rights reserved.
//

import UIKit

let AZLRefreshAnimateTime = 0.25
let AZLRefreshDefaultHeight:CGFloat = 64.0

public enum AZLRefreshState {
    //初始狀態
    case none
    //通常狀態
    case normal
    //準備刷新狀態（鬆手刷新）
    case readyRefresh
    //刷新中
    case refreshing
    //沒有更多數據
    case noMoreData
    
}


public class AZLRefreshView: UIView {
    
    weak var scrollView:UIScrollView?
    var refreshState:AZLRefreshState = .none
    
    
    public func addToScrollView(newScrollView:UIScrollView) {
        self.scrollView = newScrollView
        
    }
    
    public func endRefresh() {
        //結束刷新狀態
        self.setRefreshStatus(state: .normal)
        
    }
    
    //开始刷新
    public func beginRefresh() {
        self.setRefreshStatus(state: .refreshing)
    }
    
    
    //更新下拉/上拉的進度(通常處理動畫變化)，0就是刚好见到refreshview的位置，1就是刚好完全见到refreshview的位置（有负数和大于1的情况）
    public func updatePullPercent(percent:Double) {
        
    }
    
    //设置当前的刷新状态
    public func setRefreshStatus(state:AZLRefreshState) {
        if self.refreshState != state {
            self.refreshState = state
            self.updateRefreshState(state: state)
        }
        
    }
    
    //更新刷新状态
    public func updateRefreshState(state:AZLRefreshState) {
        
    }
    
}
