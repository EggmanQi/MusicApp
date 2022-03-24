//
//  PlayerView.swift
//  MusicApp
//
//  Created by P on 2022/3/20.
//

import Foundation
import SwiftUI
import Firebase
import AVFoundation

struct PlayerView : View {
    
    @State var album : Album
    @State var song : Song
    let player = AVPlayer()
    @State var isPlaying : Bool = false
    
    var body: some View {
        ZStack {
            Image(album.image).resizable().aspectRatio(contentMode: .fill).edgesIgnoringSafeArea(.all)
            Blur(style: .dark).edgesIgnoringSafeArea(.all)
            VStack{
                Spacer()
                AlbumArt(album: album, isWithText: false)
                Text(song.name).font(.title2).fontWeight(.light).foregroundColor(.white).padding(6).background(Color.black)
                Spacer()
                ZStack {
                    Color.white.cornerRadius(20).shadow(radius: 10).opacity(0.6)
                    HStack {
                        Button(action: self.previous, label: {
                            Image(systemName: "arrow.left.circle")
                                .resizable()
                        })
                        .frame(width: 50, height: 50, alignment: .center)
                        .foregroundColor(Color.black.opacity(0.2))
                        Button(action: self.playPause, label: {
                            Image(systemName:
                                    isPlaying ? "pause.circle.fill" : "play.circle.fill")
                            .resizable()
                        }).frame(width: 70, height: 70, alignment: .center).padding(.horizontal, 40)
                        Button(action: self.next, label: {
                            Image(systemName: "arrow.right.circle")
                                .resizable()
                        })
                        .frame(width: 50, height: 50, alignment: .center)
                        .foregroundColor(Color.black.opacity(0.2))
                    }
                }.edgesIgnoringSafeArea(.bottom).frame(height: 140, alignment: .center)
            }
        }.onAppear() {
            handleIngoreMutedState()
            loadSong(self.song)
        }
        .onDisappear() {
            player.pause()
        }
    }
    
    func handleIngoreMutedState() {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
        }
        catch {
            //MARK: report for an error
        }
    }
    
    func loadSong(_ song: Song)  {
        let storage = Storage.storage().reference(forURL: song.file)
        storage.downloadURL { url, error in
            if error != nil {
              print(error)
            } else {
                player.pause()
                player.replaceCurrentItem(with: AVPlayerItem(url: url!))
                if isPlaying == false {
                    playPause()
                }
            }
        }
    }
    
    func playPause()  {
        if isPlaying {
            player.pause()
        }else {
            player.play()
        }
        
        self.isPlaying.toggle() //触发 bool 切换
    }
    func next()  {
        if let current = album.songs.firstIndex(of: song) {
            if current == album.songs.count-1 {
                song = album.songs.first!
            } else {
                song = album.songs[current + 1]
            }
        }
        if isPlaying == true {
            playPause()
        }
        loadSong(song)
    }
    func previous()  {
        if let current = album.songs.firstIndex(of: song) {
            if current == 0 {
                song = album.songs.last!
            } else {
                song = album.songs[current - 1]
            }
        }
        if isPlaying == true {
            playPause()
        }
        loadSong(song)
    }
}

//struct PlayerView_Previews: PreviewProvider {
//    static var previews: some View {
//        let song = Song(name: "The dark end", time: "2:36", file: "")
//        let album = Album(name: "Any Moment Now", image: "3", songs: [song])
//
//        PlayerView(album: album, song: song)
//    }
//}
