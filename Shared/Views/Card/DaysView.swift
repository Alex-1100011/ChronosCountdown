//
//  DaysView.swift
//  Chronos Countdown
//
//  Created by Alessandro Alberti on 23/05/22.
//

import SwiftUI

///The single component of the ``CounterTopView``
struct DaysView: View {
    ///The number to be prominently displayed
    var days: Int
    ///Based on the component it could be "DAYS", "WEEKS", ...
    var subtitle: String
    ///When `true` a "Today" text is shown instead of the component
    var isToday: Bool
    ///When only days are shown the ``subtitle`` has a *leading* alignment, instead it is *centred* when more ``DaysView`` are displayed
    var leadingAlignment: Bool
    ///The size for the title and subtitle text
    @Environment(\.daysElementSize) var textSize
    
    
    ///This `init` lets initialise the `view` without specifying the `parameter`'s name
    init(_ days: Int, _ subtitle: String, isToday: Bool = false, leadingAlignment: Bool = false){
        self.days = days
        self.subtitle = subtitle
        self.isToday = isToday
        self.leadingAlignment = leadingAlignment
    }
    
    //MARK: body
    var body: some View {
        VStack(alignment: leadingAlignment ? .leading : .center, spacing: 0){
            //The prominent number or "Today" text
            Text(isToday ? "Today" : "\(days)")
                .font(Font.system(size: textSize.h1, weight: .semibold, design: .rounded))
                .frame(height: textSize.h1)
    
            //The subtitle
            if !isToday {
                Text(subtitle)
                    .font(Font.system(size: textSize.h2, weight: .medium))
                    .lineLimit(1)
            }
        }
        
        .foregroundColor(.white)
    }
}

//MARK: Previews
struct DaysView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DaysView(24, "DAYS")
                .previewDisplayName("Days")
            DaysView(0, "DAYS", isToday: true)
                .previewDisplayName("Today")
        }
        .padding()
        .background(Color.blue)
        .previewLayout(.sizeThatFits)
    }
}
