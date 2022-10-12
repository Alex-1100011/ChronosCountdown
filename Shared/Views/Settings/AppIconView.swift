//
//  AppIconView.swift
//  Chronos Countdown
//
//  Created by Alessandro Alberti on 10/10/22.
//

import SwiftUI

struct AppIconView: View {
    @ScaledMetric var size: CGFloat = 80
    
    var name: String
    
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
