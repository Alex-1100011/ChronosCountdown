//
//  CounterCardView.swift
//  Chronos Countdown
//
//  Created by Alessandro Alberti on 03/06/22.
//

import SwiftUI

struct CounterCardView: View {
    ///If the Always on display mode is enabled
    @Environment(\.isLuminanceReduced) private var isLuminanceReduced
    var counter: Counter
    var isSmall = false
    var editMode = false
    
    var bgImage: BackgroundImage = BackgroundImage(colorEffect: .blue)
 
    
    //MARK: body
    var body: some View {
        ZStack {
            
            
            
            //MARK: Background
            //Image
            if let _ = bgImage.image {
                bgImage.imageView()
                    .blendMode(.overlay)
                    .background{
                        bgImage.colorEffect
                    }
                    .zIndex(0)
                    .frame(height: 180)
                    .offset(bgImage.offset)
                    .scaleEffect(bgImage.scale)
                
                bgImage.maskedImage()
                    .zIndex(2)
                    .frame(height: 180)
                    .offset(bgImage.offset)
                    .scaleEffect(bgImage.scale)
                    .shadow(radius: 10)
            } else {
                //Color Background
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
            
            
            
            Group {
                //MARK: TopView
                CounterTopView(counter: counter, type: isSmall ? .showOnlyDays : .showWeeks)
                //To extend horizontally the card
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .padding(.top, editMode ? 10 : 0)
                    .zIndex(1)
                    
                Spacer()
                
                //MARK: Name
                Text(counter.name)
                    .font(Font.system(size: 25, weight: .semibold, design: .rounded))
                    .foregroundColor(.white)
                    .opacity(editMode ? 0 : 1)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                    .zIndex(3)
            }
            //Adding a shadow for better readability on images
            .shadow(radius: bgImage.image != nil ? 10 : 0)
            .padding()
        }
        
        
        
        
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
            .frame(width: 180, height: 180)
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
            .frame(width: 360, height: 180)
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
            .frame(width: 360, height: 180)
            .previewDisplayName("Image")
            
        }
        .clipped()
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
