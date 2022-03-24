//
//  MusicAppApp.swift
//  MusicApp
//
//  Created by P on 2022/3/18.
//

import SwiftUI
import Firebase

@main
struct MusicAppApp: App {
    
    let data = AppData()
    
    //MARK: 和 OC 生命周期的区别？
    init() {
        FirebaseApp.configure()
        data.loadAlbums()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(appData: data)
        }
    }
}
