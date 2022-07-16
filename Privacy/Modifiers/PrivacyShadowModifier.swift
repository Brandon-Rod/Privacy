//
//  PrivacyShadowModifier.swift
//  Privacy
//
//  Created by Brandon Rodriguez on 7/14/22.
//

import SwiftUI

struct PrivacyShadowModifier: ViewModifier {
    
    var color: Color
    
    func body(content: Content) -> some View {
        
        content
            .shadow(color: color.opacity(0.6), radius: 5, x: 2, y: 1)
        
    }
    
}
