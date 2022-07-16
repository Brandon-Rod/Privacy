//
//  PhotoPicker.swift
//  Privacy
//
//  Created by Brandon Rodriguez on 7/15/22.
//

import SwiftUI

struct PhotoPicker: UIViewControllerRepresentable {
    
    @Binding var photo: Data
    @Binding var emptyPhoto: Bool
        
    func makeUIViewController(context: Context) -> UIImagePickerController {
        
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
        
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        
        return Coordinator(photoPicker: self)
        
    }
    
    final class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
        let photoPicker: PhotoPicker
        
        init(photoPicker: PhotoPicker) {
            
            self.photoPicker = photoPicker
            
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            if let image = info[.originalImage] as? UIImage {
                
                guard let data = image.jpegData(compressionQuality: 0.80) else { return }
                
                photoPicker.photo = data
                
            } else { return }
            
            photoPicker.emptyPhoto = false
            
            picker.dismiss(animated: true)
                        
        }
        
    }
    
}
