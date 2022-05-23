//
//  CounterTopView.swift
//  Chronos Countdown
//
//  Created by Alessandro Alberti on 23/05/22.
//

import SwiftUI

///This `view` displays the ``counterComponents``
struct CounterTopView: View {
    var counter: Counter
    ///The type of components to show
    var type: Counter.Types
    
    var components: counterComponents {
        counter.getCounterComponents(type: type)
    }
    
    var showWeeks: Bool {
        !counter.isToday && type == .showWeeks && components.weeks != 0
    }
    var showMonths: Bool {
        !counter.isToday && type != .showOnlyDays && components.months != 0
    }
    var showYears: Bool {
        !counter.isToday && type == .showYears && components.years != 0
    }
    
    var body: some View {
        HStack {
            DaysView(components.days, "DAYS", isToday: counter.isToday)
                .padding(.trailing)
            
            if showWeeks {
                DaysView(components.weeks, "WEEKS")
                    .padding(.trailing)
            }
            
            if showMonths {
                DaysView(components.months, "MONTHS")
                    .padding(.trailing)
            }
            
            if type == .showYears {
                DaysView(components.years, "YEARS")
                    .padding(.trailing)
            }
        }
    }
}

struct CounterTopView_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            CounterTopView(counter:
                Counter(
                    name: "",
                    date: Date() + 60 * 60 * 24 * 48,
                    color: .blue,
                    symbolName: ""
                ), type: .showWeeks
            )
            CounterTopView(counter:
                Counter(
                    name: "",
                    date: Date(),
                    color: .blue,
                    symbolName: ""
                ), type: .showWeeks
            )
        }
        .padding()
        .background(Color.red)
        .previewLayout(.sizeThatFits)
    }
}
