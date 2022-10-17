//
//  SettingsView.swift
//  Chronos Countdown
//
//  Created by Alessandro Alberti on 19/09/22.
//

import SwiftUI

///This `View` lets the user change the App Icon and other settings
struct SettingsView: View {
    var body: some View {
        NavigationView {
            
            List{
                
                Section("App icon"){
                    ForEach(icons, id: \.self){ icon in
                        AppIconView(name: icon)
                    }
                }
                
                Section("About"){
                    Text("About")
                }
            }
            
            .navigationTitle("Settings")
        }
    }
    
    var icons = ["Default", "Orange", "Green", "Black", "Beta", "DALLE", "Pixel"]
    
}


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
