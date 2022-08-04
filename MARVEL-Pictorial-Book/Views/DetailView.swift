//
//  DetailView.swift
//  MARVEL-Pictorial-Book
//
//  Created by 花堂　瑠聖 on 2022/08/04.
//

import SwiftUI

struct DetailView: View {
    
    let url: String?
    
    var body: some View {
        WebView(urlString: url
        )
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(url: "https://www.google.com")
    }
}
