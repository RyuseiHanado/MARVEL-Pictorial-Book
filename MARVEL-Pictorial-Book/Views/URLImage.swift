//
//  URLImage.swift
//  MARVEL-Pictorial-Book
//
//  Created by 花堂　瑠聖 on 2022/08/04.
//

import SwiftUI

struct URLImage: View {

    let url: String
    @ObservedObject private var imageDownloader = ImageDownloader()

    init(url: String) {
        // iOS9以降はhttp通信はできないため、https通信に置換
        self.url = url.replacingOccurrences(of: "http://", with: "https://")
        self.imageDownloader.downloadImage(url: self.url)
    }

    var body: some View {
        if let imageData = self.imageDownloader.downloadData {
            let img = UIImage(data: imageData)
            return  Image(uiImage: img!).resizable()
        } else {
            return Image(uiImage: UIImage(systemName: "icloud.and.arrow.down")!).resizable()
        }
    }
}
