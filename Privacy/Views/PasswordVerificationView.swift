//
//  PasswordVerificationView.swift
//  Privacy
//
//  Created by Brandon Rodriguez on 7/15/22.
//

import SwiftUI

struct PasswordVerificationView: View {
    
    var text: String
    var color: Color
    
    var body: some View {
        
        Text(text)
            .font(.title2)
            .foregroundColor(.white)
            .frame(width: 250)
            .padding()
            .background(color)
            .cornerRadius(15)
            .modifier(PrivacyShadowModifier(color: color))
        
    }
    
}

struct PasswordVerificationView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordVerificationView(text: "Set Password", color: .blue)
    }
}
