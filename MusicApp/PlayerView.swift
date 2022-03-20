//
//  PlayerView.swift
//  MusicApp
//
//  Created by P on 2022/3/20.
//

import Foundation

import SwiftUI

struct PlayerView : View {
    
    var album : Album
    var song : Song
    
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
        }
    }
    
    func playPause()  {
        self.isPlaying.toggle() //触发 bool 切换
    }
    func next()  {
        
    }
    func previous()  {
        
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        let song = Song(name: "The dark end", time: "2:36")
        let album = Album(name: "Any Moment Now", image: "3", songs: [song])
        
        PlayerView(album: album, song: song)
    }
}
