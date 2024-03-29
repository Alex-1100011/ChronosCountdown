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
    @ScaledMetric var nameSize: CGFloat = 25
    ///To override the default padding
    ///
    ///Used to provide less padding in widgets
    var padding: CGFloat? = nil
    
    var reducedImageResolution:Bool = true
    ///The image to display as a background
    ///
    ///When not in edit mode the image will have a smaller resolution
    private var image: UIImage? {
        let image = counter.image
        
        //Reducing Image size when not in editMode
        if reducedImageResolution{
            return image?.preparingThumbnail(of: CGSize(width: 700, height: 700))
        }
        return image
    }
 
    
    //MARK: body
    var body: some View {
        VStack(alignment: .leading) {
            //MARK: TopView
            CounterTopView(counter: counter, type: isSmall ? .showOnlyDays : .showWeeks)
            //To extend horizontally the card
                .frame(maxWidth: .infinity, alignment: .leading)
                
            Spacer()
            
            //MARK: Name
            Text(counter.name)
                .font(Font.system(size: nameSize, weight: .semibold, design: .rounded))
                .minimumScaleFactor(0.01)
                .foregroundColor(.white)
        }
        //Adding a shadow for better readability on images
        .shadow(radius: counter.image != nil ? 10 : 0)
        .padding(.all, padding)
        
        
        
        .background(
            ZStack {
                
                //MARK: Image Background
                if let image {
                    
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .opacity(isLuminanceReduced ? 0.2 : 1)
                    
                //MARK: Color Background
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
