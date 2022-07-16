//
//  UnlockPhotoView.swift
//  Privacy
//
//  Created by Brandon Rodriguez on 7/8/22.
//

import SwiftUI

struct UnlockPhotoView: View {
    
    @ObservedObject var privacyVM: PrivacyViewModel
        
    @Binding var photoLocked: Bool
    @Binding var showUnlock: Bool
    
    @State private var password = ""
    @State private var passwordError = false
    @State private var showPassword = false
    
    var body: some View {
        
        ZStack {
            
            VStack(alignment: .leading, spacing: 10) {
                
                Text("Enter Password To Unlock Photo")
                    .font(.title2)
                    .foregroundColor(.blue)
                
                HStack {
                    
                    if showPassword {
                        
                        TextField("Password", text: $password)
                            .submitLabel(.go)
                            .modifier(PrivacyTextFieldModifier())
                        
                    } else {
                        
                        SecureField("Password", text: $password)
                            .submitLabel(.go)
                            .modifier(PrivacyTextFieldModifier())
                        
                    }
                    
                    Button {
                        
                        withAnimation(.easeInOut) {
                            
                            showPassword.toggle()
                            
                        }
                        
                    } label: {
                        
                        Image(systemName: showPassword ? "eye" : "eye.slash")
                        
                    }
                    
                }
                .onSubmit {
                    
                    if !self.privacyVM.validatePassword(password) {
                        
                        passwordError = true
                        
                    } else {
                        
                        photoLocked = false
                        showUnlock = false
                        
                    }
                    
                }
                
                HStack {
                    
                    Spacer()
                    
                    Button {
                        
                        withAnimation(.easeInOut) {
                            
                            if !self.privacyVM.validatePassword(password) {
                                
                                passwordError = true
                                
                            } else {
                                
                                photoLocked = false
                                showUnlock = false
                                
                            }
                            
                        }
                        
                    } label: {
                        
                        PasswordVerificationView(text: "Unlock", color: .blue)
                        
                    }
                    
                }
                
                Spacer()
                
            }
            .padding()
            
            if passwordError {
                
                PopUpView(showingPopUp: $passwordError, title: "Incorrect Password", message: "Please Try Again.")
                    .padding()
                
            }
            
        }
        
    }
    
}
