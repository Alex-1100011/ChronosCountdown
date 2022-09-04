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

            
            TextField("Title", text: $counter.name)
                .font(Font.system(size: 30, weight: .semibold, design: .rounded))
                .foregroundColor(.white)
                .padding()
                .padding(.leading, 5)
            
                .background(
                    
                    RoundedRectangle(cornerRadius: 9)
                        .foregroundColor(counter.color)
                        .brightness(-0.2)
                    //Matching the TextField padding
                        .padding()
                    //Adding more padding from the TextField
                        .padding(-4)
                )
        }
        .frame(height: 180)
    }
}

struct CreateTopView_Previews: PreviewProvider {
    static var previews: some View {
        CreateTopView(
            counter: .constant(Counter(name: "Hell-o", date: Date(), color: getColorFrom(image: UIImage(named: "sperlonga")) ?? .red, symbolName: "car", image: UIImage(named: "sperlonga"))))
        .previewLayout(.sizeThatFits)
    }
}
