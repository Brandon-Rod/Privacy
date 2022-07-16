//
//  PopUpView.swift
//  Privacy
//
//  Created by Brandon Rodriguez on 7/14/22.
//

import SwiftUI

struct PopUpView: View {
    
    @Binding var showingPopUp: Bool
    
    var title: String
    var message: String
    
    var body: some View {
        
        VStack(spacing: 5) {
            
            Text(title)
                .font(.title2)
                .foregroundColor(.white)
            
            Color.white
                .clipShape(Capsule())
                .frame(height: 2)
            
            Text(message)
                .foregroundColor(.white)
                .padding(.top, 5)
            
            Button { withAnimation(.easeInOut) { showingPopUp = false } } label: {
                
                Text("Ok")
                    .foregroundColor(.blue)
                    .frame(height: 45)
                    .frame(maxWidth: .infinity)
                    .background(.white)
                    .cornerRadius(10)
                    .modifier(PrivacyShadowModifier(color: .black))
                
            }
            .padding(.top, 5)
            
        }
        .padding()
        .background(.blue)
        .cornerRadius(15)
        .modifier(PrivacyShadowModifier(color: .blue))
        
    }
    
}

struct PopUpView_Previews: PreviewProvider {
    static var previews: some View {
        PopUpView(showingPopUp: .constant(true), title: "Success", message: "Password has been deleted")
    }
}
