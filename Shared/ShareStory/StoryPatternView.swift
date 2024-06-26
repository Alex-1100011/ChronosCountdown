//
//  IgStoryView.swift
//  Chronos (iOS)
//
//  Created by Alessandro Alberti on 30/11/22.
//

import SwiftUI

struct StoryPatternView: View {
    var counter: Counter
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(
                    Gradient(colors: [(counter.color + 0.3)!, (counter.color - 0.25)!])
                )
            
            Grid{
                ForEach(0 ..< 15) { item in
                    GridRow {
                        ForEach(0 ..< 10) { _ in
                            Image(systemName: counter.symbolName)
                                .symbolVariant(.fill)
                                .font(.system(size: 120))
                                .blendMode(.overlay)
                                .opacity(0.3)
                        }
                    }
                }
            }
            .rotationEffect(Angle(degrees: -25))
        }
        .padding(-200)
        ///Assigning a frame with 9:16 ratio (otherwise when exporting will default to 1:1)
        .frame(width: 900, height: 1600)
    }
}

struct IgStoryView_Previews: PreviewProvider {
    static var previews: some View {
        
        
        StoryPatternView(counter: Counter(name: "Hello", date: Date(), color: testColours[3], symbolName: symbols[9].symbolName))
        
        let bgRenderer = ImageRenderer(content: StoryPatternView(counter: Counter()))
//        bgRenderer.scale = 3.0
        Image(uiImage: bgRenderer.uiImage!)
            .previewLayout(.sizeThatFits)
        
        StoryPatternView(counter: Counter())
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .scaleEffect(0.3)
        
        
        
    }
}
