//
//  ContentView.swift
//  MARVEL-Pictorial-Book
//
//  Created by 花堂　瑠聖 on 2022/08/04.
//

import SwiftUI

struct ContentView: View {
    
    // NetworkManagerを初期化
    // @ObservableObject
    // NetworkManagerクラスでObservableObjectを継承しているため、NetworkManagerを監視対象にできる
    // networkManagerが更新される度に、通知される
    @ObservedObject var networkManager = NetworkManager()
    
    var body: some View {
        // NavigationView
        // 画面遷移するなら必要
        NavigationView {
            // リスト
            // 第一引数は配列
            // networkManagerで公開されているpostsにアクセスできる
            // データが更新される度に、リストが再構築されるトリガーが発動する
            // 第二引数はクロージャー
            List(networkManager.posts) { post in
                // NavigationLink - 各セルの右側にボタンを作成
                // プレゼンテーションをトリガする
                //第一引数destination: 行き先を指定する
                NavigationLink(destination: DetailView(url: post.urls[0].url)) {
                    HStack {
                        Text(post.name)
                        URLImage(url: post.thumbnail.path + "." + post.thumbnail.extension)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50, alignment: .center)
                    }
                }
                
                .navigationTitle("MARVEL PB")
            }
            // onAppear
            // UIKit のviewDidLoatと同じ働き
            .onAppear {
                // データ取得
                self.networkManager.fetchData()
            }
        }
    }
}
