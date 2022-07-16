//
//  SetPasswordView.swift
//  Privacy
//
//  Created by Brandon Rodriguez on 7/13/22.
//

import SwiftUI

struct SetPasswordView: View {
    
    @ObservedObject var privacyVM: PrivacyViewModel
    
    @Namespace private var animation
    
    @FocusState private var setPasswordFF: SetPasswordFocusField?
    
    @Binding var showModal: Bool
    @Binding var photoLocked: Bool
    
    @State private var password1 = ""
    @State private var password2 = ""
        
    var passwordValid: Bool { passwordsMatch && !password1.isEmpty }
    var passwordsMatch: Bool { password1 == password2 }
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            
            Text("Enter a password to protect your photo")
                .font(.title2)
                .foregroundColor(.blue)
            
            VStack(spacing: 15) {
                
                SecureField("Password", text: $password1)
                    .focused($setPasswordFF, equals: .password1)
                    .modifier(PrivacyTextFieldModifier())
                
                SecureField("Verify Password", text: $password2)
                    .focused($setPasswordFF, equals: .password2)
                    .submitLabel(.go)
                    .modifier(PrivacyTextFieldModifier())
                
            }
            .onSubmit {
                
                if setPasswordFF == .password1 {
                    
                    setPasswordFF = .password2
                    
                } else {
                    
                    if passwordValid {
                        
                        privacyVM.updateStoredPassword(password1)
                        photoLocked = false
                        showModal = false
                        
                    }
                    
                }
                
            }
            
            if passwordValid {
                
                HStack {
                    
                    Spacer()
                    
                    Button {
                        
                        withAnimation(.easeInOut) {
                            
                            if passwordValid {
                                
                                privacyVM.updateStoredPassword(password1)
                                photoLocked = false
                                showModal = false
                                
                            }
                            
                        }
                        
                    } label: {
                        
                        PasswordVerificationView(text: "Set Password", color: .blue)
                            .matchedGeometryEffect(id: "match", in: animation)
                        
                    }
                    
                }
                
            } else {
                
                PasswordVerificationView(text: "Passwords Don't Match", color: .red)
                    .matchedGeometryEffect(id: "match", in: animation)
                
            }
            
            Spacer()
                                
        }
        .padding()
        .animation(.easeInOut(duration: 0.3), value: passwordValid)
                
    }
    
}
