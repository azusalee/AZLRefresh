//
//  AZLRefreshResourceManager.swift
//  ALExampleTest
//
//  Created by yangming on 2018/11/13.
//  Copyright © 2018年 Mac. All rights reserved.
//

import UIKit

class AZLRefreshResourceManager: NSObject {
    
    static let shared:AZLRefreshResourceManager = AZLRefreshResourceManager()
    
    var refreshBundle:Bundle? = nil
    //var languageBundle:Bundle? = nil
    
    func getRefreshBundle() -> Bundle? {
        if self.refreshBundle != nil {
            return self.refreshBundle
        }
        let mainBundle = Bundle.init(for: AZLRefreshResourceManager.self)
        if let path = mainBundle.path(forResource: "AZLRefresh", ofType: "bundle") {
            if let refreshBundle = Bundle.init(path: path) {
                self.refreshBundle = refreshBundle
                return refreshBundle
            }
        }
        return nil
    }
    
//    func getLanguageBundle() -> Bundle? {
//        if self.languageBundle != nil {
//            return self.languageBundle
//        }
//
//        var language = NSLocale.preferredLanguages[0]
//        if language.hasPrefix("en") {
//            language = "en"
//        }else if language.hasPrefix("zh") {
//            if language.contains("Hans") == true {
//                language = "zh-Hans" // 简体中文
//            }else{
//                language = "zh-Hant" // 繁體中文
//            }
//        }else{
//            language = "en"
//        }
//        if let bundle = Bundle.init(path: self.getRefreshBundle()?.path(forResource: language, ofType: "lproj") ?? "") {
//            self.languageBundle = bundle
//            return bundle
//        }
//
//        return nil
//    }
    
    //获取本地化字符
    func localizedString(key:String) -> String {
        if let bundle = self.getRefreshBundle() {
            return bundle.localizedString(forKey: key, value: nil, table: nil)
        }
        return key
    }
    
}
