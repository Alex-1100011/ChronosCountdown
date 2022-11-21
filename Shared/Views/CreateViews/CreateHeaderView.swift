//
//  CreateTopView.swift
//  Chronos Countdown
//
//  Created by Alessandro Alberti on 04/09/22.
//

import SwiftUI

///This `View` is the top section of the ``CreateView`` and lets **preview** the counter and **edit** its name
struct CreateHeaderView: View {
    @Binding var counter: Counter
    ///To dismiss the `Parent View`
    @Binding var showSheet: Bool
    ///The scrollOffset will affect the bg image
    @Binding var offset: CGFloat
    
    private var colorStyle: AnyShapeStyle {
        counter.image != nil ?
        AnyShapeStyle(Material.ultraThinMaterial) :
        AnyShapeStyle(counter.color)
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
                    
                VStack(alignment: .leading){
                    //MARK: Counter
                    CounterTopView(counter: counter, type: .showWeeks)
                        .frame(height: 50)
                        .padding(.top)
                    Spacer()
                    //MARK: Textfield
                    TextField("Title", text: $counter.name)
                        .font(Font.system(size: 30, weight: .semibold, design: .rounded))
                        .foregroundColor(.white)
                        .overlay(){
                            if counter.name.isEmpty{
                                Text("Title")
                                    .font(Font.system(size: 30, weight: .semibold, design: .rounded))
                                    .foregroundColor(.white)
                                    .opacity(0.7)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .padding(.leading, 5)
                        .padding(3)
                        .background(
                            //Textfield Background
                            RoundedRectangle(cornerRadius: 9)
                                .foregroundStyle(colorStyle)
                                .brightness(-0.2)
                                .padding(.trailing, 50)
                        )
                        
                }
                .padding()
                //MARK: Background
                .background(){
                        if let image = counter.image {
                            
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .offset(y:
                                        //Header expanding
                                        offset > 0 ? 0 :
                                        //Header getting smaller
                                        (offset > -100 ? -offset/2 : 50)
                                )
                        } else {
                            Rectangle()
                                .foregroundStyle(counter.color.gradient)
                        }
                    }
            
            //MARK: Close Button
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
            .padding(.top, 7)
            .offset(y:
                //Header expanding
                offset > 0 ? 0 :
                //Header getting smaller
                (offset > -100 ? -offset : 100))
                
            
        }
    }
}

struct CreateTopView_Previews: PreviewProvider {
    static var previews: some View {
        
        CreateHeaderView(
            counter: .constant(Counter(name: "", date: Date(), color: .blue, symbolName: "car")), showSheet: .constant(true), offset: .constant(0))
        .frame(height: 180)
        .previewLayout(.sizeThatFits)
        .previewDisplayName("Color")
        
        CreateHeaderView(
            counter: .constant(Counter(name: "Hello", date: Date(), color: getColorFrom(image: UIImage(named: "sperlonga")) ?? .red, symbolName: "car", image: UIImage(named: "sperlonga"))), showSheet: .constant(true), offset: .constant(0))
        
        .previewLayout(.sizeThatFits)
        .previewDisplayName("Image")
       
    }
}
