//
//  ActionsView.swift
//  Privacy
//
//  Created by Brandon Rodriguez on 7/15/22.
//

import SwiftUI

struct ActionsView: View {
    
    @AppStorage("emptyPhoto") var emptyPhoto = true
    @AppStorage("photoLocked") var photoLocked = false
    
    @ObservedObject var privacyVM: PrivacyViewModel
    
    @Binding var showingPhotoPicker: Bool
        
    var body: some View {
        
        HStack(spacing: 10) {
            
//            Delete
            Button {
                
                withAnimation(.easeInOut) {
                                        
                    privacyVM.updateStoredPassword("")
                    photoLocked = false
                    emptyPhoto = true
                    
                }
                
            } label: { PrivacyButtonView(image: "trash", color: .red) }
            
            Spacer()
            
//            Change Password
            Button { withAnimation(.easeInOut) { privacyVM.changePasswordModal = true } } label: {
                
                PrivacyButtonView(image: "arrow.left.arrow.right", color: .green)
                
            }
            
//            Change Photo
            if !photoLocked {
                
                Button { withAnimation(.easeInOut) { showingPhotoPicker = true }
                    
                } label: {
                    
                    PrivacyButtonView(image: "photo.on.rectangle.angled", color: .orange)
                    
                }
                
            }

//            Lock
            Button {
                
                withAnimation(.easeInOut) {
                    
                    if !photoLocked {
                        
                        photoLocked = true
                        
                    } else {
                        
                        privacyVM.tryBiometricAuthentication()
                        
                    }
                    
                }
                
            } label: {
                
                PrivacyButtonView(image: photoLocked ? "lock" : "lock.open", color: photoLocked ? .blue : .yellow)
                
            }
            
        }
        .animation(.easeInOut, value: privacyVM.photoLocked)
        
    }
    
}
