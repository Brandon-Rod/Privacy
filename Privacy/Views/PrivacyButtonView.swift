//
//  PrivacyButtonView.swift
//  Privacy
//
//  Created by Brandon Rodriguez on 7/6/22.
//

import SwiftUI

struct PrivacyButtonView: View {
    
    var image: String
    var color: Color
    
    var body: some View {
        
        Image(systemName: image)
            .resizable()
            .scaledToFit()
            .frame(width: 25, height: 25)
            .foregroundColor(.white)
            .padding()
            .background(color)
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            .modifier(PrivacyShadowModifier(color: color))
        
    }
    
}

struct PrivacyButtonView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyButtonView(image: "lock.open", color: .blue)
    }
}
