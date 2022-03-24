//
//  data.swift
//  MusicApp
//
//  Created by P on 2022/3/22.
//

import Foundation
import SwiftUI
import Firebase

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
    var file : String
}

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
                            let songFile = s.value["file"] as? String ?? "song file error"
                            songsArr.append(Song(name: songName,
                                                 time: songTime,
                                                 file: songFile))
                        }
                    }
                    
                    self.albums.append(Album(name: name, image: image, songs: songsArr))
                }
            }
        }
    }
    
    //MARK: @Published public 项目内任何文件都可见
    @Published public var albums = [Album]()

}
