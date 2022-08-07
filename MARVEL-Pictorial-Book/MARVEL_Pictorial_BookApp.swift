//
//  MARVEL_Pictorial_BookApp.swift
//  MARVEL-Pictorial-Book
//
//  Created by 花堂　瑠聖 on 2022/08/04.
//

import SwiftUI

@main
struct MARVEL_Pictorial_BookApp: App {
    
    // SwiftUIでAppDelegate機能を使用するため追加
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

// 以下からはオリジナルで記述
class AppDelegate: UIResponder, UIApplicationDelegate {
    // 起動時にトリガされる
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        // 起動時におこなう処理を記述
        print("起動！！")
        
        return true
    }
    // 必要に応じて処理を追加
}
