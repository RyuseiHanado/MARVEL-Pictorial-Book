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
    @ObservedObject var musicplayer = SoundPlayer()   // インスタンス化
    
    // 検索機能、入力テキストを保持
    @ObservedObject var model =  Model()
    
    // 検索機能
    // .searchable には、isSearching とdismissSearch という 2 つの環境値があります。
    // 下記2つは任意で追加 Cancel処理で必要
    @Environment(\.isSearching) private var isSearching: Bool
//    @Environment(\.dismissSearch) private var dismissSearch
    
    init() {
        // NavigationBarデザイン
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 0.93, green: 0.11, blue: 0.14, alpha: 1.00)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance

        // リストデザイン
        UITableView.appearance().backgroundColor = UIColor.clear
        UITableViewCell.appearance().backgroundColor = .clear
        //検索バー背景色
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = .white
        // Cancelボタン色
        UIView.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = .white
        // カーソル色
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = .blue
        // プレースホルダー色
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: "test", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        // 虫眼鏡アイコン色
        let image = UIImage(systemName: "magnifyingglass")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        UISearchBar.appearance().setImage(image, for: .search, state: .normal)
        // Clearボタン（x）色
        let imgClear = UIImage(systemName: "xmark")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        UISearchBar.appearance().setImage(imgClear, for: .clear, state: .normal)
        
    }
    
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
                        Text(post.name).font(.title)
                            .foregroundColor(.black)
                        Spacer()
                        URLImage(url: post.thumbnail.path + "." + post.thumbnail.extension)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100, alignment: .center)
                    }
                }
                // List背景色
                .listRowBackground(Color(red: 0.95, green: 0.95, blue: 0.95, opacity: 0.8))
//                                .navigationBarTitleDisplayMode(.inline)
            }
            // NavigationBarとの重なりを防止
//            .padding(.top, 1)
            // 背景画像設定
            .background(
                Image("marvelcomic-wallpapers-mono")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
            )
            // iOS16から背景画像の表示で、下記のコードが必要
            .scrollContentBackground(.hidden)
            .navigationTitle("MARVEL PB")
            // navigationBarにオブジェクトを追加
            .navigationBarItems(trailing:
                                    // ボタン
                                Button(action:{
                // 音を再生
                musicplayer.musicPlayer()
            })
                                {
                // 再生状況に応じてアイコンを可変
                if musicplayer.isPlaying {
                    Image(systemName:"pause.circle")
                        .foregroundColor(.white)
                } else {
                    Image(systemName:"play.circle")
                        .foregroundColor(.white)
                }
                
            }
            )
            //検索ボックス
            .searchable(
                text: $model.searchText,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: Text("Search characters")
            )
            .onSubmit(of: .search) {
                // データ取得
                self.networkManager.fetchData(model.searchText)
            }
            // .Searche
            .onChange(of: model.searchText) { value in
                print("On Changed!!")
                // Cancel押した瞬間、入力テキストはリセットされるのかな。現状あきらめ
                // Cancel時の処理
                if model.searchText.isEmpty && !isSearching {
                    //Search cancelled here
                    print("Canceled!!")
                    // データ取得
                    self.networkManager.fetchData(model.searchText)
                }
            }
            // 入力文字色
            .foregroundColor(.black)
            
            
            
            
            // onAppear
            // UIKit のviewDidLoatと同じ働き
            .onAppear {
                print("onAppear!!!!")
                // データ取得
                self.networkManager.fetchData(model.searchText)
            }
        }
        // 戻るボタンの色
        .accentColor(.white)
    }
}

class Model: ObservableObject {
    
    @Published var searchText = ""
    @Published var familyNames: [String] = []
    
    func testMethod() {
        print("searched!!")
    }
    
}
