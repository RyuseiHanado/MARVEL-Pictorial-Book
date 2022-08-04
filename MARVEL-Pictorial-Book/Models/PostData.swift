//
//  PostData.swift
//  MARVEL-Pictorial-Book
//
//  Created by 花堂　瑠聖 on 2022/08/04.
//

import Foundation

// APIから取得するデータ構造に基づいて構成
struct Results: Decodable {
    let code: Int
    let status: String
    let attributionText: String
    let data: Datas
}

struct Datas: Decodable {
    let results: [Post]
}

// Identifiableを準拠
// Identifiableに基づいてPostオブジェクトのidの順序を認識できる
struct Post: Decodable, Identifiable {
    // Identifiableに準拠するため、idは必須になる
    // APIから取得するobjectIDを反映
    var id: Int
    let name: String
    let description: String
    let modified: String
    let thumbnail: Thumbnail
    let resourceURI: String
    let urls: [Url]
}

struct Thumbnail: Decodable {
    let path: String
    // 予約語はを変数にする場合、``をつける
    let `extension` : String
}

struct Url: Decodable {
    let type: String
    let url: String
}
