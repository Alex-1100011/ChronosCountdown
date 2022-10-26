//
//  AppIconView.swift
//  Chronos Countdown
//
//  Created by Alessandro Alberti on 10/10/22.
//

import SwiftUI

///This `View` displays and sets a single App Icon from its ``AppIconView/name``
struct AppIconView: View {
    ///The name of the App Icon
    ///
    ///It should correspond to the name of the asset following the structure `"AppIcon-\(name)"`
    var name: String
    ///The size of the app Icon Image, it also affects the rounded corners
    @ScaledMetric var size: CGFloat = 80
    
    var body: some View {
        Button{
            setIcon(named: name == "Default" ? nil : "AppIcon-\(name)")
        } label: {
            VStack {
                Image(name)
                    .resizable()
                    .frame(width: size, height: size)
                    .clipShape(RoundedRectangle(cornerRadius: size / 4.5))
                Text(name)
            }
        }
        .buttonStyle(.plain)
    }
    
    ///Sets the App's Icon from the given name, when nil the default icon is set
    func setIcon(named iconName: String?){
        UIApplication.shared.setAlternateIconName(iconName) { (error) in
            if let error = error {
                print("Failed request to update the app’s icon: \(error)")
            }
        }
    }
    
}

struct AppIconView_Previews: PreviewProvider {
    static var previews: some View {
        AppIconView(name: "Black")
    }
}
