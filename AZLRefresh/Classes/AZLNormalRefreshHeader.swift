//
//  AZLNormalRefreshHeader.swift
//  ALExampleTest
//
//  Created by yangming on 2018/11/13.
//  Copyright © 2018年 Mac. All rights reserved.
//

import UIKit

public class AZLNormalRefreshHeader: AZLRefreshHeader {
    
    private let contentLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: AZLRefreshDefaultHeight))
    private let indicateView = UIActivityIndicatorView.init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentLabel.frame = self.bounds
        self.contentLabel.textAlignment = .center
        self.contentLabel.font = UIFont.systemFont(ofSize: 15)
        self.contentLabel.textColor = UIColor.black
        self.contentLabel.numberOfLines = 0
        self.contentLabel.autoresizingMask = [.flexibleWidth]
        self.addSubview(self.contentLabel)
        
        self.indicateView.style = .gray
        self.indicateView.hidesWhenStopped = true
        self.indicateView.frame = CGRect.init(x: 0, y: 0, width: 40, height: 40)
        self.indicateView.center = CGPoint.init(x: 50, y: self.contentLabel.center.y)
        self.addSubview(self.indicateView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override public func updateRefreshState(state: AZLRefreshState) {
        super.updateRefreshState(state: state)
        
        self.updateContent(text: state.stateText)
        switch state {
        case .normal:
            //print("通常狀態")
            self.indicateView.stopAnimating()
            
            
        case .readyRefresh:
            //print("鬆手可刷新狀態")
            break
            
        case .refreshing:
            //print("正在刷新狀態")
            self.indicateView.startAnimating()
            
        default:
            break
            
        }
    }
    
    func updateContent(text:String?) {
        if self.contentLabel.text != text {
            self.contentLabel.text = text
            let nsStr = NSString.init(string: text ?? "")
            let textSize = nsStr.boundingRect(with: CGSize.init(width: 9999, height: 9999), options: .usesFontLeading, attributes: [NSAttributedString.Key.font:self.contentLabel.font], context: nil)
            self.contentLabel.frame = CGRect.init(x: 0, y: 0, width: textSize.width, height: textSize.height)
            
            self.contentLabel.center = CGPoint.init(x: self.bounds.size.width/2, y: self.bounds.size.height/2)
            self.indicateView.center = CGPoint.init(x: self.contentLabel.center.x-self.contentLabel.bounds.size.width/2-self.indicateView.bounds.size.width/2, y: self.contentLabel.center.y)
            
        }
    }
    
    override public func updatePullPercent(percent: Double) {
        super.updatePullPercent(percent: percent)
    }

}


fileprivate extension AZLRefreshState {
    var stateText:String {
        switch self {
        case .normal:
            return AZLRefreshResourceManager.shared.localizedString(key: "AZLRefreshHeaderNormalText")
        case .readyRefresh:
            return AZLRefreshResourceManager.shared.localizedString(key: "AZLRefreshHeaderPullingText")
        case .refreshing:
            return AZLRefreshResourceManager.shared.localizedString(key: "AZLRefreshHeaderRefreshingText")
        case .noMoreData:
            return AZLRefreshResourceManager.shared.localizedString(key: "AZLRefreshNoMoreDataText")
        default:
            return ""
        }
    }
}
