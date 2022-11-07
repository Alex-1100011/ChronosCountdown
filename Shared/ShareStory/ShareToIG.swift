//
//  ShareToIG.swift
//  Chronos (iOS)
//
//  Created by Alessandro Alberti on 07/11/22.
//

import Foundation
import UIKit
import SwiftUI



@MainActor func shareToStory(counter: Counter){
    
    let renderer = ImageRenderer(content: StickerView(counter: counter))
    renderer.scale = 3.0
    
    let topColor = String((counter.color + 0.3)!)
    let bottomColor = String((counter.color - 0.25)!)

    if let storiesUrl = URL(string: "instagram-stories://share"), let image = renderer.uiImage {
        
        if UIApplication.shared.canOpenURL(storiesUrl) {
            guard let imageData = image.pngData() else { return }
            let pasteboardItems: [String: Any] = [
                "com.instagram.sharedSticker.stickerImage": imageData,
                "com.instagram.sharedSticker.backgroundTopColor": "#\(topColor)",
                "com.instagram.sharedSticker.backgroundBottomColor": "#\(bottomColor)"
            ]
            if #available(iOS 10, *) {
                let pasteboardOptions = [
                    UIPasteboard.OptionsKey.expirationDate: Date().addingTimeInterval(300)
                ]
                UIPasteboard.general.setItems([pasteboardItems], options: pasteboardOptions)
                UIApplication.shared.open(storiesUrl, options: [:], completionHandler: nil)
             }
        }
    }
}

struct StickerView: View {
    var counter: Counter
    
    var body: some View{
        CounterCardView(counter: counter)
            .frame(width: 360, height: 180)
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .drawingGroup()
            .shadow(
                color: ((counter.color - 0.3)?.opacity(0.35))!,
                radius: 10,
                y: 5)
            .padding(30)
    }
}


struct Instagram_Previews: PreviewProvider {
    static let counter = Counter()
    
    static var previews: some View {
        let renderer = ImageRenderer(content: StickerView(counter: Counter()))
        
        let topColor = (counter.color + 0.3)!
        let bottomColor = (counter.color - 0.25)!
        
        ZStack {
            Rectangle()
                .foregroundStyle(Gradient(colors: [topColor,bottomColor]))
                .edgesIgnoringSafeArea(.all)
            
            Image(uiImage: renderer.uiImage!)
        }
        
        VStack{
            Text(String(topColor))
            Text(String(bottomColor))
        }
    }
}
