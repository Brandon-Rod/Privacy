//
//  ContentView.swift
//  Privacy
//
//  Created by Brandon Rodriguez on 7/6/22.
//

import SwiftUI

struct PrivacyView: View {
    
    @StateObject var privacyVM = PrivacyViewModel()
    
    @AppStorage("photo") var photo = Data()
    @AppStorage("emptyPhoto") var emptyPhoto = true
    @AppStorage("photoLocked") var photoLocked = false
        
    var dismissPassword: some ToolbarContent {
        
        ToolbarItem(placement: .navigationBarTrailing) {
            
            Button("Done") { withAnimation(.easeInOut) { privacyVM.changePasswordModal = false } }
            
        }
        
    }
    
    var dismissUnlock: some ToolbarContent {
        
        ToolbarItem(placement: .navigationBarTrailing) {
            
            Button("Done") { withAnimation(.easeInOut) { privacyVM.showUnlock = false } }
            
        }
        
    }
    
    var body: some View {
        
        NavigationView {
            
            VStack(spacing: 10) {
                
                if emptyPhoto {
                                        
                    Button { withAnimation(.easeInOut) { privacyVM.showingPhotoPicker = true } } label: {
                        
                        PasswordVerificationView(text: "Add Photo", color: .blue)
                        
                    }
                    
                } else {
                    
                    ActionsView(photoLocked: photoLocked, privacyVM: privacyVM, showingPhotoPicker: $privacyVM.showingPhotoPicker)
                    
                    if let selectedImage = UIImage(data: photo) {
                        
                        Image(uiImage: selectedImage)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                            .cornerRadius(10)
                            .modifier(PrivacyShadowModifier(color: .black))
                            .redacted(reason: photoLocked ? .placeholder : .privacy)
                        
                    } else {
                        
                        Image("Test")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                            .cornerRadius(10)
                            .modifier(PrivacyShadowModifier(color: .black))
                            .redacted(reason: photoLocked ? .placeholder : .privacy)
                        
                    }
                    
                    Spacer()
                    
                }
                                
            }
            .padding()
            .navigationTitle("Privacy")
            .sheet(isPresented: $privacyVM.showingPhotoPicker) { PhotoPicker(photo: $photo, emptyPhoto: $emptyPhoto) }
            .sheet(isPresented: $privacyVM.changePasswordModal) {
                
                NavigationView {
                    
                    SetPasswordView(privacyVM: privacyVM, showModal: $privacyVM.changePasswordModal, photoLocked: $photoLocked)
                        .navigationTitle("Change Password")
                        .toolbar { dismissPassword }

                }
                
            }
            .sheet(isPresented: $privacyVM.showUnlock) {
                
                if privacyVM.isPasswordBlank {
                    
                    NavigationView {
                        
                        SetPasswordView(privacyVM: privacyVM, showModal: $privacyVM.showUnlock, photoLocked: $photoLocked)
                            .navigationTitle("Add A Password")
                            .toolbar { dismissUnlock }
                        
                    }
                    
                } else {
                    
                    NavigationView {
                        
                        UnlockPhotoView(privacyVM: privacyVM, photoLocked: $photoLocked, showUnlock: $privacyVM.showUnlock)
                            .navigationTitle("Unlock Photo")
                            .toolbar { dismissUnlock }
                        
                    }
                    
                }
                
            }

        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyView()
    }
}
