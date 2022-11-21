//
//  CreateTopView.swift
//  Chronos Countdown
//
//  Created by Alessandro Alberti on 04/09/22.
//

import SwiftUI

///This `View` is the top section of the ``CreateView`` and lets **preview** the counter and **edit** its name
struct CreateTopView: View {
    @Binding var counter: Counter
    ///To dismiss the `Parent View`
    @Binding var showSheet: Bool
    
    private var colorStyle: AnyShapeStyle {
        counter.image != nil ?
        AnyShapeStyle(Material.ultraThinMaterial) :
        AnyShapeStyle(counter.color)
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            
            ZStack(alignment: .bottom) {
                CounterCardView(counter: counter, editMode: true)
                
                //Textfield
                TextField("Title", text: $counter.name)
                    .font(Font.system(size: 30, weight: .semibold, design: .rounded))
                    .foregroundColor(.white)
                    .padding()
                    .padding(.leading, 5)
                    .padding(3)
                
                    .background(
                        //Textfield Background
                        RoundedRectangle(cornerRadius: 9)
                            .foregroundStyle(colorStyle)
                            .brightness(-0.2)
                            .padding()
                        
                        
                    )
            }
            
            Button(action: {showSheet = false}) {
                Image(systemName: "circle.fill")
                    .foregroundStyle(colorStyle)
                    .brightness(-0.2)
                    .font(.largeTitle)
                    .overlay{
                        Image(systemName: "xmark")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                    }
                    .contentShape(Circle())
                    .hoverEffect(.lift)
                    .padding()
            }
            .buttonStyle(.plain)
            
                
            
        }
    }
}

struct CreateTopView_Previews: PreviewProvider {
    static var previews: some View {
        CreateTopView(
            counter: .constant(Counter(name: "Hello", date: Date(), color: getColorFrom(image: UIImage(named: "sperlonga")) ?? .red, symbolName: "car", image: UIImage(named: "sperlonga"))), showSheet: .constant(true))
        .previewLayout(.sizeThatFits)
        .previewDisplayName("Image")
        CreateTopView(
            counter: .constant(Counter(name: "Hello", date: Date(), color: .blue, symbolName: "car")), showSheet: .constant(true))
        .previewLayout(.sizeThatFits)
        .previewDisplayName("Color")
    }
}
