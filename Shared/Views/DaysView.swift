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
    
    ///This `init` lets initialise the `view` without specifying the `parameter`'s name
    init(_ days: Int, _ subtitle: String, isToday: Bool = false){
        self.days = days
        self.subtitle = subtitle
        self.isToday = isToday
    }
    
    var body: some View {
        VStack(alignment: .leading){
            //The prominent number or "Today" text
            Text(isToday ? "Today" : "\(days)")
                .font(Font.system(size: 50, weight: .semibold, design: .rounded))
            //The subtitle
            if !isToday {
                Text(subtitle)
                    .font(.headline)
            }
        }
        .foregroundColor(.white)
    }
}

struct DaysView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DaysView(24, "DAYS")
            DaysView(0, "DAYS")
        }
        .padding()
        .background(Color.blue)
        .previewLayout(.sizeThatFits)
    }
}
