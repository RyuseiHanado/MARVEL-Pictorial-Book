//
//  WebView.swift
//  MARVEL-Pictorial-Book
//
//  Created by 花堂　瑠聖 on 2022/08/04.
//
//

import Foundation
// WebViewに必要
import WebKit
import SwiftUI


// UIViewRepresentable：UILitViiewを継承
struct WebView: UIViewRepresentable {
    /// The type of view to present.
    let urlString: String?
    // UIViewRepresentableを準拠するために、下記の２つのメソッドが必要
    // makeUIView
    // UIKit WebViewを作成し、SwiftUIViewに変換
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let safeString = urlString {
            if let url = URL(string: safeString) {
                let request = URLRequest(url: url)
                uiView.load(request)
            }
        }
    }

}
