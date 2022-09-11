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
    var editMode = false
    
    //MARK: body
    var body: some View {
        VStack(alignment: .leading) {
            //MARK: TopView
            CounterTopView(counter: counter, type: isSmall ? .showOnlyDays : .showWeeks)
            //To extend horizontally the card
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, editMode ? 10 : 0)
                
            Spacer()
            
            //MARK: Name
            Text(counter.name)
                .font(Font.system(size: 25, weight: .semibold, design: .rounded))
                .foregroundColor(.white)
                .opacity(editMode ? 0 : 1)
        }
        //Adding a shadow for better readability on images
        .shadow(radius: counter.image != nil ? 10 : 0)
        .padding()
        
        
        //MARK: Background
        .background(
            ZStack {
                if let image = counter.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                } else {
                    ZStack(alignment: .trailing) {
                        
                        counter.color
                        
                        Image(systemName: counter.symbolName)
                            .symbolVariant(.fill)
                            .font(.system(size: 90))
                            .imageScale(.large)
                            .foregroundColor(counter.color)
                            .brightness(-0.2)
                            .rotationEffect(Angle(degrees: -20))
                            .offset(x: 10, y: 30)
                            //Hide the symbol in edit mode
                            .opacity(editMode ? 0 : 1)
                        
                    }
                }
            }
           
        )
        
        
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
            
            CounterCardView(counter: Counter(
                name: "Trip to Italy",
                date:
                    Calendar.current.date(
                        byAdding: .day,
                        value: 180,
                        to: Date()
                    ) ?? Date(),
                color: .green,
                symbolName: "tram",
                image: UIImage(named: "procida")
                )
            )
            .previewDisplayName("Image")
            
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
