//
//  SettingsView.swift
//  Chronos Countdown
//
//  Created by Alessandro Alberti on 19/09/22.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView {
            
            List{
                
                Section("App icon"){
                    Button("Default Icon"){
                        setIcon(named: nil)
                    }
                    Button("Orange Icon"){
                        setIcon(named: "AppIcon-Orange")
                    }
                    Button("Green Icon"){
                        setIcon(named: "AppIcon-Green")
                    }
                    Button("Black Icon"){
                        setIcon(named: "AppIcon-Black")
                    }
                    Button("Beta Icon"){
                        setIcon(named: "AppIcon-Beta")
                    }
                    Button("Pixel Icon"){
                        setIcon(named: "AppIcon-Pixel")
                    }
                    Button("DALLE Icon"){
                        setIcon(named: "AppIcon-DALLE")
                    }
                }
                
                Section("About"){
                    Text("About")
                }
            }
            
            .navigationTitle("Settings")
        }
        
    }
    
    func setIcon(named iconName: String?){
        UIApplication.shared.setAlternateIconName(iconName) { (error) in
            if let error = error {
                print("Failed request to update the app’s icon: \(error)")
            }
        }
    }
    
}


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
