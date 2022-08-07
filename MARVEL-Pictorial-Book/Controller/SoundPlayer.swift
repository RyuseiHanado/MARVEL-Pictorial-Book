//
//  SoundPlayer.swift
//  MARVEL-Pictorial-Book
//
//  Created by 花堂　瑠聖 on 2022/08/05.
//

import UIKit
import AVFoundation

class SoundPlayer: NSObject , ObservableObject, AVAudioPlayerDelegate {
    
    let music_data = NSDataAsset(name: "avengers_theme")!.data   // 音源の指定
    var music_player:AVAudioPlayer!
    // @Published
    // 公開状態にする
    // isPlaying(再生状況)に応じてアイコンの表示を変えたいため、外部からの監視対象にしておく
    @Published var isPlaying = false
    var isInitial = true
    
    // 音楽を再生
    func musicPlayer(){
        
        if isInitial {
            do{
                music_player=try AVAudioPlayer(data:music_data)   // 音楽を指定
                music_player.play()   // 音楽再生
                // 再生終了検知のデリゲートメソッドを使用するために記述
                music_player.delegate = self
                isPlaying = true
                isInitial = false
            }catch{
                print("エラー発生.音を流せません")
            }
            // Initisl処理時はここで終了
            // ;はがないと下の処理に続いてしまうらしい
            return;
        }
        
        if !isPlaying {
            music_player.play()   // 音楽再生
            isPlaying = true
        } else {
            // 音楽停止
            music_player.pause()
            isPlaying = false
        }
    }
    
    // 再生終了を検知
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print("Did finish Playing Sound!!")
        isPlaying = false
        isInitial = true
    }
}
