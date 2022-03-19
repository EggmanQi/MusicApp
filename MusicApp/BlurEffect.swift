//
//  BlurEffect.swift
//  MusicApp
//
//  Created by P on 2022/3/19.
//

import Foundation
import SwiftUI

struct Blur : UIViewRepresentable {
    var style : UIBlurEffect.Style = .systemMaterial
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}
