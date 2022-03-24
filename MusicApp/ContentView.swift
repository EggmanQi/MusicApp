//
//  ContentView.swift
//  MusicApp
//
//  Created by P on 2022/3/18.
//
//https://www.youtube.com/watch?v=hkmnQcsz1Bs&list=PL3MWPU0RhJzGhbQSsv1U9JcRBBlX9vF4Q&index=2

import SwiftUI

//MARK: 数据结构


struct AlbumArt : View {
    var album : Album
    var isWithText : Bool
    var body: some View {
        ZStack(alignment: .bottom, content: {
            Image(album.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 200, height: 200, alignment: .center)
            if isWithText == true {
                ZStack{
                    Blur(style: .dark)
                    Text(album.name).foregroundColor(.white)
                }.frame(height: 60, alignment: .bottom)
            }
        })
        .frame(width: 200, height: 200, alignment: .center)
        .clipped()
        .cornerRadius(20)
        .shadow(radius: 5, x: 5, y: 5)
        .padding(20)
    }
}

struct SongCell : View {
    var album : Album
    var song : Song
    var body: some View {
        NavigationLink (
            destination: PlayerView(album: album, song: song), label: {
                HStack {
                    ZStack {
                        Circle()
                            .frame(width: 50, height: 50, alignment: .center)
                            .foregroundColor(.blue)
                        Circle()
                            .frame(width: 20, height: 20, alignment: .center)
                            .foregroundColor(.white)
                    }
                    Text(song.name).bold()
                    Spacer()
                    Text(song.time)
                }
                .padding(20)
            }).buttonStyle(PlainButtonStyle())
    }
}

struct ContentView: View {
    
    @ObservedObject var appData : AppData //TODO: 如何监听？
    
    @State private var currenAlbum : Album?
    
    //MARK: Swift UI 布局方式
    var body: some View {
        NavigationView{
            ScrollViewReader { scrollProxy in
                ScrollView(.horizontal,
                           showsIndicators: false,
                           content: {
                    LazyHStack {
                        ForEach(self.appData.albums, id: \.self, content: { album in
                            AlbumArt(album: album, isWithText: true).onTapGesture{
                                self.currenAlbum = album
                                withAnimation {
                                    scrollProxy.scrollTo(album, anchor: .center) //MARK: 滚动对象 & 对齐方式
                                }
                            }
                        })
                    }.background(Color.red) //TODO: 为什么特别高
                }) .frame(alignment: .top).background(Color.accentColor)
                LazyVStack{
                    if self.appData.albums.first == nil {
                        //TODO: 异常处理页
                        EmptyView()
                    }else {
                        ForEach(
                            (self.currenAlbum?.songs ?? self.appData.albums.first!.songs) ,
                            id: \.self,
                            content: { song in
                                SongCell(album: self.currenAlbum ?? self.appData.albums.first!, song: song)
                            })
                    }
                }
                .background(Color.yellow)
            }.navigationTitle("My band name.")
        }
    }
}

//MARK: 类似 hot reload 的即时浏览 UI 效果
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let album = Album(name: "Any Moment Now", image: "3", songs: [Song(name: "The dark end", time: "2:36", file: "")])
//        SongCell(album: album, song: Song(name: "The dark end", time: "2:36"))
        AlbumArt(album: album, isWithText: false)
    }
}
