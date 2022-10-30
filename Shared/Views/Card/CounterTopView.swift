//
//  CounterTopView.swift
//  Chronos Countdown
//
//  Created by Alessandro Alberti on 23/05/22.
//

import SwiftUI

///This `view` displays the ``counterComponents`` for the ``CounterCardView`` and the `rectangular widget` 
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
    ///The font size of the ``DaysView/days`` text
    @ScaledMetric var daysSize: CGFloat = 50
    ///The font size of the ``DaysView/subtitle``
    @ScaledMetric var subtitleSize: CGFloat = 20
    
    
    //MARK: body
    var body: some View {
        HStack(spacing: 20) {
            
            let days = abs(components.days)
            
            if counter.isToday || days != 0 {
                DaysView(days, days == 1 ? "DAY" : "DAYS", isToday: counter.isToday, leadingAlignment: type == .showOnlyDays)
            }
            
            if showWeeks {
                let weeks = abs(components.weeks)
                DaysView(weeks, weeks == 1 ? "WEEK" : "WEEKS")

            }
            
            if showMonths {
                let months = abs(components.months)
                DaysView(months, months == 1 ? "MONTH" : "MONTHS")

            }
            
            if type == .showYears {
                let years = abs(components.years)
                DaysView(years, years == 1 ? "YEAR" : "YEARS")

            }
        }
        .environment(\.daysElementSize, (daysSize,subtitleSize))
    }
}


extension EnvironmentValues {
    var daysElementSize: (h1: CGFloat, h2: CGFloat) {
    get { self[DaysElementSizeKey.self] }
    set { self[DaysElementSizeKey.self] = newValue }
  }
}

private struct DaysElementSizeKey: EnvironmentKey {
  static let defaultValue: (h1: CGFloat, h2: CGFloat) = (50,20)
}


//MARK: Previews
struct CounterTopView_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            //showWeeks
            CounterTopView(counter:
                Counter(
                    name: "",
                    date: Date() + 60 * 60 * 24 * 48,
                    color: .blue,
                    symbolName: ""
                ), type: .showWeeks
            )
            .previewDisplayName("showWeeks")
            //Today
            CounterTopView(counter:
                Counter(
                    name: "",
                    date: Date(),
                    color: .blue,
                    symbolName: ""
                ), type: .showWeeks
            )
            .previewDisplayName("Today")
        }
        .padding()
        .background(Color.red)
        .previewLayout(.sizeThatFits)
    }
}

