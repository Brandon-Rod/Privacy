//
//  PrivacyTextFieldModifier.swift
//  Privacy
//
//  Created by Brandon Rodriguez on 7/14/22.
//

import SwiftUI

struct PrivacyTextFieldModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        
        content
            .padding()
            .cornerRadius(15)
            .overlay(
            
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .stroke(.blue, lineWidth: 2)
            
            )
            .modifier(PrivacyShadowModifier(color: .blue))
        
    }
    
}
