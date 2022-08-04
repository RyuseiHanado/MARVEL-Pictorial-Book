//
//  NetworkManager.swift
//  MARVEL-Pictorial-Book
//
//  Created by 花堂　瑠聖 on 2022/08/04.
//

import Foundation
// ハッシュ化に必要
import CommonCrypto

// ObservableObject
// これは、実際にそのプロパティの 1 つまたは多くを関心のある人にブロードキャストし始めることができることを意味します。
class NetworkManager: ObservableObject {
    
    // @Published
    // 公開状態にする
    @Published var posts = [Post]()
    
    // MD5hash化メソッド
    func MD5(data: Data) -> String {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        var digest = [UInt8](repeating: 0, count: length)
        _ = data.withUnsafeBytes { CC_MD5($0, CC_LONG(data.count), &digest) }
        return digest.map { String(format: "%02x", $0) }.joined(separator: "")
    }
    
    func fetchData() {
        
        // UnixTime
        let unixtime: String = String(Date().timeIntervalSince1970)
        let concatStr = String(unixtime) + PRIV_KEY + PUBLIC_KEY
        // hash化
        let data = concatStr.data(using: .utf8)
        let hash  = MD5(data: data!)

        // データ作成
        let setData = "ts=" + unixtime + "&apikey=" + PUBLIC_KEY + "&hash=" + hash;
        
        // 文字列からURLを生成できるか判定
        if let url = URL(string: "https://gateway.marvel.com:443/v1/public/characters?limit=100&" + setData) {
            // default構成を使用し、セッションを生成
            let session = URLSession(configuration: .default)
            // session.taskのみ設定するタスクを作成
            let task = session.dataTask(with: url) { (data, responce, error) in
                // エラーがnilか判定
                if error == nil {
                    let decoder = JSONDecoder()
                    // dataはoptionalなので判定が必要
                    if let safeData = data {
                        // decodeメソッドはスローできる
                        // decodeメソッドはtryが必要
                        do {
                            // デコーダーでセッションから返されたデータをデコード
                            // 第一引数 データ型を指定
                            // 第二引数 使用するデータ
                            let result = try decoder.decode(Results.self, from: safeData)
                            // メインスレッドでオブジェクト（posts）の更新をおこなう
                            DispatchQueue.main.sync {
                                // PostDataファイルのResult.hits(配列)と一致すること
                                self.posts = result.data.results
                            }
                        } catch {
                            print(error)
                        }
                    }
                    
                }
            }
            // ネットワークタスクを開始
            task.resume()
        }
    }
}
