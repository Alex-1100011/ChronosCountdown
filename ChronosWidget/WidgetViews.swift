//
//  WidgetViews.swift
//  Chronos (iOS)
//
//  Created by Alessandro Alberti on 26/10/22.
//

import SwiftUI
import WidgetKit

///The rectangular widget on watchOS has more space available compared to the LockScreen widget, so this View accommodates for this difference.
struct RectangularWidget: View {
    var counter: Counter
    ///The size for the ``CounterTopView``
    var size: (h1: CGFloat, h2: CGFloat){
        #if os(watchOS)
        return (40, 15)
        #endif
        return (30,10)
    }
    
    var body: some View {
        ZStack {
            
            VStack(alignment: .leading, spacing: 0) {
                HStack{
                    Image(systemName: counter.symbolName)
                        .font(.system(size: 15))
                    Text(counter.name)
                }
                .symbolVariant(.fill)
                .fontWeight(.semibold)
#if os(watchOS)
                .foregroundColor(counter.color)
                .widgetAccentable()
                .padding(.bottom, 2)
#endif
                
                
                CounterTopView(counter: counter, type: .showWeeks, daysSize: size.h1, subtitleSize: size.h2)
                
                    .frame(maxWidth: .infinity, alignment: .leading)
                
            }
        }
        
    }
}

struct WidgetViews_Previews: PreviewProvider {
    static var previews: some View {
        RectangularWidget(counter: Counter())
            .previewContext(WidgetPreviewContext(family: .accessoryRectangular))
            .previewDisplayName("accessoryRectangular")
    }
}
