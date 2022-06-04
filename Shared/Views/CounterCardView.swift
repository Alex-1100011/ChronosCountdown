//
//  CounterCardView.swift
//  Chronos Countdown
//
//  Created by Alessandro Alberti on 03/06/22.
//

import SwiftUI

struct CounterCardView: View {
    var counter: Counter
    var isSmall = false
    
    var body: some View {
        VStack(alignment: .leading) {
            //TopView
            CounterTopView(counter: counter, type: isSmall ? .showOnlyDays : .showWeeks)
                .padding(.bottom)
            //Name
            Text(counter.name)
                .font(Font.system(size: 25, weight: .semibold, design: .rounded))
                .foregroundColor(.white)
        }
        .padding()
        .frame(width: isSmall ? 180 : 360, height: 160, alignment: .leading)
        
        .background(
            ZStack(alignment: .trailing) {
                
                counter.color
                
                Image(systemName: counter.symbolName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 120)
                    .foregroundColor(counter.color)
                    .brightness(-0.2)
                    .rotationEffect(Angle(degrees: -20))
                    .offset(x: 10, y: 35)
                
            }
        )
        
        .clipShape(RoundedRectangle(cornerRadius: 30))
        
    }
}

struct CounterCardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            
            CounterCardView(counter: Counter(
                name: "Hello",
                date:
                    Calendar.current.date(
                        byAdding: .day,
                        value: 24,
                        to: Date()
                    ) ?? Date(),
                color: .blue,
                symbolName: "car"),
                            isSmall: true
            )
            .previewDisplayName("Small")
            
            CounterCardView(counter: Counter(
                name: "Hello",
                date:
                    Calendar.current.date(
                        byAdding: .day,
                        value: 24,
                        to: Date()
                    ) ?? Date(),
                color: .blue,
                symbolName: "car")
            )
            .previewDisplayName("Large")
            
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
