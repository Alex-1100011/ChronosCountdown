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
    var roundCorners = true
    
    //MARK: body
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
        .frame(maxWidth: .infinity, alignment: .leading)
        
        .background(
            ZStack(alignment: .trailing) {
                
                Rectangle().fill(counter.color.gradient)
                
                Image(systemName: counter.symbolName)
                    .symbolVariant(.fill)
                    .font(.system(size: 90))
                    .imageScale(.large)
                    .foregroundColor(counter.color)
                    .brightness(-0.2)
                    .rotationEffect(Angle(degrees: -20))
                    .offset(x: 10, y: 30)

            }
        )
        
        .clipShape(RoundedRectangle(cornerRadius: roundCorners ? 30 : 0))
        
    }
}

//MARK: Previews
struct CounterCardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            
            CounterCardView(counter: Counter(
                name: "Trip to SF",
                date:
                    Calendar.current.date(
                        byAdding: .day,
                        value: 24,
                        to: Date()
                    ) ?? Date(),
                color: .orange,
                symbolName: "airplane"),
                            isSmall: true
            )
            .frame(width: 170, height: 170)
            .previewDisplayName("Small")
            
            CounterCardView(counter: Counter(
                name: "Train",
                date:
                    Calendar.current.date(
                        byAdding: .day,
                        value: 24,
                        to: Date()
                    ) ?? Date(),
                color: .green,
                symbolName: "tram")
            )
            .previewDisplayName("Large")
            
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
