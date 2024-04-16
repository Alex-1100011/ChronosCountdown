//
//  BackgroundPicker.swift
//  Chronos Countdown
//
//  Created by Alessandro Alberti on 01/09/22.
//

import SwiftUI
import PhotosUI

///This `View` lets the user pick a color or Image, the values are passed with the `color` and `image` bindings
struct BackgroundPicker: View {
    @Binding var color: Color
    @Binding var image: UIImage?
    ///The selected item of the photoPicker
    @State private var selectedPhotoItem: PhotosPickerItem? = nil
    @ScaledMetric var gridSize: CGFloat = 45
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: gridSize))], spacing: gridSize/3){
            
            //MARK: Colors
            ForEach(colours, id: \.self) { elementColor in
                
                CircleElementButton(
                    color: elementColor,
                    isSelected: elementColor == color,
                    symbolColor: .white)
                {
                    color = elementColor
                    //Deselecting the image
                    image = nil
                }
                
            }
            
            //MARK: Multicolor
            CircleElementView(
                isSelected:
                //When no image and no other colours are selected
                    (image == nil) &&
                    (colours.firstIndex(of: color) == nil),
                symbolColor: .thinMaterial,
                bgImage: UIImage(named: "multicolor"))
            .tint(color)
            .hoverEffect(.lift)
            .overlay{
                ColorPicker("color picker", selection: $color, supportsOpacity: false)
                    .labelsHidden()
                    .opacity(0.015)
            }
            
            //MARK: Image
            PhotosPicker(
                selection: $selectedPhotoItem,
                matching: .images,
                photoLibrary: .shared()) {
                    
                    if image != nil {
                        CircleElementView(
                            isSelected: true,
                            symbolName: "photo",
                            symbolColor: .regularMaterial,
                            bgImage: image)
                    } else {
                        CircleElementView(
                            isSelected: false,
                            symbolName: "photo",
                            symbolColor: .gray)
                        .tint(Color(UIColor.tertiarySystemGroupedBackground))
                    }
                    
                }
                .hoverEffect(.lift)
                .buttonStyle(PlainButtonStyle())
                ///Update the ``image`` variable  with the picker's selection
                .onChange(of: selectedPhotoItem) { photo in
                    Task {
                        // Retrieve selected asset in the form of Data
                        if let data = try? await photo?.loadTransferable(type: Data.self) {
                            image = UIImage(data: data)
                            
                            if let imageColor = getColorFrom(image: image) {
                                color = imageColor
                            }
                        }
                    }
                }
        }
    }
    
    ///The selectable colours
    var colours: [Color] = [
        Color(hex: "027AFF"), Color(hex: "1DB2DF"), Color(hex: "44D7B6"),
        Color(hex: "35C759"), Color(hex: "FFCC02"), Color(hex: "FFA700"), Color(hex: "A736FF"), Color(hex: "E020B8"),
        Color(hex: "E02020"), Color(hex: "FF7100")]
}



struct BackgroundPicker_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundPicker(color: .constant(.blue), image: .constant(nil))
            .padding()
            .previewLayout(.sizeThatFits)
    }
}


