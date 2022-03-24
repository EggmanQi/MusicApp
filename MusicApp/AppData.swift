//
//  data.swift
//  MusicApp
//
//  Created by P on 2022/3/22.
//

import Foundation
import SwiftUI
import Firebase

class AppData : ObservableObject {
    
    func loadAlbums() {
        Firestore.firestore().collection("albums").getDocuments { (shapshot, error) in
            if error != nil {
                print(error)
            }else {
                for document in shapshot!.documents {
                    print(" |||||||||||||||| ------------ ", document)
                    let name = document.data()["name"] as? String ?? "name error"
                    let image = document.data()["image"] as? String ?? "1"
                    let songs = document.data()["songs"] as? [String : [String : Any]]
                    
                    var songsArr = [Song]()
                    
                    if let songs = songs {
                        for s in songs {
                            let songName = s.value["name"] as? String ?? "song name error"
                            let songTime = s.value["time"] as? String ?? "song time error"
                            songsArr.append(Song(name: songName, time: songTime))
                        }
                    }
                    
                    self.albums.append(Album(name: name, image: image, songs: songsArr))
                }
            }
        }
    }
    
    //MARK: @Published public 项目内任何文件都可见
    @Published public var albums = [Album]()
//    [
//        Album(name: "Album-1", image: "1", songs: [
//            Song(name: "Song-1", time: "2:00"),
//            Song(name: "Song-2", time: "2:30"),
//            Song(name: "Song-3", time: "3:00"),
//            Song(name: "Song-4", time: "3:30"),
//        ]),
//        Album(name: "Album-2", image: "2", songs: [
//            Song(name: "Song-5", time: "2:00"),
//            Song(name: "Song-6", time: "2:30"),
//            Song(name: "Song-7", time: "3:00"),
//            Song(name: "Song-8", time: "3:30"),
//        ]),
//        Album(name: "Album-3", image: "3", songs: [
//            Song(name: "Song-1", time: "2:00"),
//            Song(name: "Song-2", time: "2:30"),
//            Song(name: "Song-3", time: "3:00"),
//            Song(name: "Song-4", time: "3:30"),
//        ]),
//        Album(name: "Album-4", image: "4", songs: [
//            Song(name: "Song-5", time: "2:00"),
//            Song(name: "Song-6", time: "2:30"),
//            Song(name: "Song-7", time: "3:00"),
//            Song(name: "Song-8", time: "3:30"),
//        ]),
//        Album(name: "Album-5", image: "5", songs: [
//            Song(name: "Song-1", time: "2:00"),
//            Song(name: "Song-2", time: "2:30"),
//            Song(name: "Song-3", time: "3:00"),
//            Song(name: "Song-4", time: "3:30"),
//        ]),
//        Album(name: "Album-6", image: "6", songs: [
//            Song(name: "Song-5", time: "2:00"),
//            Song(name: "Song-6", time: "2:30"),
//            Song(name: "Song-7", time: "3:00"),
//            Song(name: "Song-8", time: "3:30"),
//        ]),
//    ]
}
