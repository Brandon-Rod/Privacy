//
//  PrivacyViewModel.swift
//  Privacy
//
//  Created by Brandon Rodriguez on 7/7/22.
//

import SwiftUI
import LocalAuthentication

final class PrivacyViewModel: ObservableObject {
    
    @AppStorage("photoLocked") var photoLocked = false
    
    @Published var showUnlock = false
    @Published var changePasswordModal = false
    @Published var showPopUp = false
    @Published var showingPhotoPicker = false
        
    var isPasswordBlank: Bool {
        
      getStoredPassword() == ""
        
    }
    
    func getStoredPassword() -> String {
        
        let kCW = KeychainWrapper()
        
        if let password = try? kCW.getGenericPasswordFor(account: "Privacy", service: "Unlock") {
            
            return password
            
        }
        
        return ""
        
    }
    
    func updateStoredPassword(_ password: String) {
        
        let kCW = KeychainWrapper()
        
        do {
            
            try kCW.storeGenericPasswordFor(account: "Privacy", service: "Unlock", password: password)
            
        } catch let error as KeychainWrapperError {
            
            print("Exception setting password: \(error.message ?? "No Message.")")
            
        } catch {
            
            print("An error occurred setting the password.")
            
        }
        
    }
    
    func validatePassword(_ password: String) -> Bool {
        
      let currentPassword = getStoredPassword()
      return password == currentPassword
        
    }
    
    func tryBiometricAuthentication() {
        
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            
            let reason = "Authenticate to unlock photo."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { authenticated, error in
                
                DispatchQueue.main.async {
                    
                    if authenticated {
                        
                        withAnimation(.easeInOut) { self.photoLocked = false }
                        
                    } else {
                        
                        if let errorString = error?.localizedDescription {
                            
                            print("Error in biometric policy evaluation: \(errorString)")
                            
                        }
                        
                        self.showUnlock = true
                        
                    }
                    
                }
                
            }
            
        } else {
            
            if let errorString = error?.localizedDescription {
                
                print("Error in biometric policy evaluation: \(errorString)")
                
            }
            
            self.showUnlock = true
            
        }
        
    }
    
}
