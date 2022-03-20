//
//  ContentView.swift
//  MusicApp
//
//  Created by P on 2022/3/18.
//
//https://www.youtube.com/watch?v=hkmnQcsz1Bs&list=PL3MWPU0RhJzGhbQSsv1U9JcRBBlX9vF4Q&index=2

import SwiftUI

//MARK: 数据结构
struct Album : Hashable {
    var id = UUID()
    var name : String
    var image : String
    var songs : [Song]
}

struct Song : Hashable {
    var id = UUID()
    var name : String
    var time : String
}

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
    
    var albums = createDemoAlbums()
    @State private var currenAlbum : Album?
    
    //MARK: Swift UI 布局方式
    var body: some View {
        NavigationView{
            ScrollViewReader { scrollProxy in
                ScrollView(.horizontal,
                           showsIndicators: false,
                           content: {
                    LazyHStack {
                        ForEach(self.albums, id: \.self, content: { album in
                            AlbumArt(album: album, isWithText: true).onTapGesture{
                                self.currenAlbum = album
                                withAnimation {
                                    scrollProxy.scrollTo(album, anchor: .center) //MARK: 滚动对象 & 对齐方式
                                }
                            }
                        })
                    }
                })
                LazyVStack{
                    ForEach(
                        (self.currenAlbum?.songs ?? self.albums.first!.songs) ,
                        id: \.self,
                        content: { song in
                            SongCell(album: self.currenAlbum ?? self.albums.first!, song: song)
                        })
                }
            }.navigationTitle("My band name.")
        }
    }
}

//MARK: 类似 hot reload 的即时浏览 UI 效果
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let album = Album(name: "Any Moment Now", image: "3", songs: [Song(name: "The dark end", time: "2:36")])
        SongCell(album: album, song: Song(name: "The dark end", time: "2:36"))
        AlbumArt(album: album, isWithText: false)
    }
}

func createDemoAlbums() -> [Album] {
    return [
        Album(name: "Album-1", image: "1", songs: [
            Song(name: "Song-1", time: "2:00"),
            Song(name: "Song-2", time: "2:30"),
            Song(name: "Song-3", time: "3:00"),
            Song(name: "Song-4", time: "3:30"),
        ]),
        Album(name: "Album-2", image: "2", songs: [
            Song(name: "Song-5", time: "2:00"),
            Song(name: "Song-6", time: "2:30"),
            Song(name: "Song-7", time: "3:00"),
            Song(name: "Song-8", time: "3:30"),
        ]),
        Album(name: "Album-3", image: "3", songs: [
            Song(name: "Song-1", time: "2:00"),
            Song(name: "Song-2", time: "2:30"),
            Song(name: "Song-3", time: "3:00"),
            Song(name: "Song-4", time: "3:30"),
        ]),
        Album(name: "Album-4", image: "4", songs: [
            Song(name: "Song-5", time: "2:00"),
            Song(name: "Song-6", time: "2:30"),
            Song(name: "Song-7", time: "3:00"),
            Song(name: "Song-8", time: "3:30"),
        ]),
        Album(name: "Album-5", image: "5", songs: [
            Song(name: "Song-1", time: "2:00"),
            Song(name: "Song-2", time: "2:30"),
            Song(name: "Song-3", time: "3:00"),
            Song(name: "Song-4", time: "3:30"),
        ]),
        Album(name: "Album-6", image: "6", songs: [
            Song(name: "Song-5", time: "2:00"),
            Song(name: "Song-6", time: "2:30"),
            Song(name: "Song-7", time: "3:00"),
            Song(name: "Song-8", time: "3:30"),
        ]),
    ]
}
