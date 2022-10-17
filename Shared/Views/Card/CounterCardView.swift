//
//  CounterCardView.swift
//  Chronos Countdown
//
//  Created by Alessandro Alberti on 03/06/22.
//

import SwiftUI

///The main visual representation of a ``Counter``
struct CounterCardView: View {
    ///If the Always on display mode is enabled the card background is dimmed and an outline is added.
    @Environment(\.isLuminanceReduced) private var isLuminanceReduced
    var counter: Counter
    var isSmall = false
    ///When shown in the ``CreateTopView`` certain elements are hidden
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
                
                //Image
                if let image = counter.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .opacity(isLuminanceReduced ? 0.2 : 1)
                    
                //Color Background
                } else {
                    ZStack(alignment: .trailing) {
                        
                        Rectangle()
                            .foregroundStyle(counter.color.gradient)
                        
                            //More contrast in AODisplay mode
                            .opacity(isLuminanceReduced ? 0.2 : 1)
                        
                        //Hide the symbol in AODisplay mode
                        if !isLuminanceReduced{
                            Image(systemName: counter.symbolName)
                                .symbolVariant(.fill)
                                .font(.system(size: 90))
                                .imageScale(.large)
                                .foregroundColor(counter.color)
                                .brightness(-0.2)
                                .rotationEffect(Angle(degrees: -20))
                                .offset(x: 10, y: 30)
                                .opacity(editMode ? 0 : 1)
                        }
                    }
                     
                }
                    
                
                //Always On
                if isLuminanceReduced {
                    RoundedRectangle(cornerRadius: 20)
                        .strokeBorder(counter.color, lineWidth: 5)
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
//            .environment(\.isLuminanceReduced, true)
            
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
                image: UIImage(named: "sperlonga")
                )
            )
            .previewDisplayName("Image")
            
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
