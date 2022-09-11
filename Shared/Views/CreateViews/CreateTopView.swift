//
//  CreateTopView.swift
//  Chronos Countdown
//
//  Created by Alessandro Alberti on 04/09/22.
//

import SwiftUI

struct CreateTopView: View {
    @Binding var counter: Counter
    
    var body: some View {
        ZStack(alignment: .bottom) {
            CounterCardView(counter: counter, editMode: true)
                .edgesIgnoringSafeArea(.all)

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
                        .foregroundStyle(counter.image != nil ?
                                         AnyShapeStyle(Material.ultraThinMaterial) :
                                         AnyShapeStyle(counter.color))
                        .brightness(-0.2)
                        .padding()
                    
                    
                )
        }
        .frame(height: 180)
    }
}

struct CreateTopView_Previews: PreviewProvider {
    static var previews: some View {
        CreateTopView(
            counter: .constant(Counter(name: "Hello", date: Date(), color: getColorFrom(image: UIImage(named: "sperlonga")) ?? .red, symbolName: "car", image: UIImage(named: "sperlonga"))))
        .previewLayout(.sizeThatFits)
        .previewDisplayName("Image")
        CreateTopView(
            counter: .constant(Counter(name: "Hello", date: Date(), color: .blue, symbolName: "car")))
        .previewLayout(.sizeThatFits)
        .previewDisplayName("Color")
    }
}
