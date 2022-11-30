//
//  ShareToIG.swift
//  Chronos (iOS)
//
//  Created by Alessandro Alberti on 07/11/22.
//

import Foundation
import UIKit
import SwiftUI



@MainActor func shareToStory(counter: Counter, pattern: Bool){
    
    let stickerRenderer = ImageRenderer(content: StickerView(counter: counter))
    stickerRenderer.scale = 3.0
    
    

    if let storiesUrl = URL(string: "instagram-stories://share") {
        
        if UIApplication.shared.canOpenURL(storiesUrl) {
            guard let stickerImage = stickerRenderer.uiImage?.pngData() else { return }
            
            var pasteboardItems: [String: Any] = [
                "com.instagram.sharedSticker.stickerImage": stickerImage,
            ]
            
            if pattern {
                //MARK: Pattern background
                let bgRenderer = ImageRenderer(content: StoryPatternView(counter: counter))
                bgRenderer.scale = 3.0
                
                guard let bgImage = bgRenderer.uiImage?.pngData() else { return }
                pasteboardItems["com.instagram.sharedSticker.backgroundImage"] = bgImage
                
            } else {
                //MARK: Color background
                let topColor = String((counter.color + 0.3)!)
                let bottomColor = String((counter.color - 0.25)!)
                
                pasteboardItems["com.instagram.sharedSticker.backgroundTopColor"] = "#\(topColor)"
                pasteboardItems["com.instagram.sharedSticker.backgroundBottomColor"] = "#\(bottomColor)"
            }
            
            if #available(iOS 10, *) {
                let pasteboardOptions = [
                    UIPasteboard.OptionsKey.expirationDate: Date().addingTimeInterval(300)
                ]
                UIPasteboard.general.setItems([pasteboardItems], options: pasteboardOptions)
                UIApplication.shared.open(storiesUrl, options: [:], completionHandler: nil)
             }
        } else {
            //Error instagram not installed
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
