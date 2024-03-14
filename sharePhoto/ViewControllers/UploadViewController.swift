//
//  UploadViewController.swift
//  sharePhoto
//
//  Created by Zülal Sarıoğlu on 14.03.2024.
//

import UIKit
import FirebaseStorage

class UploadViewController: UIViewController  , UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var discriptionTextField: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gesture = UITapGestureRecognizer(target: self, action: #selector(clickImageView))
        photoImageView.isUserInteractionEnabled = true
        photoImageView.addGestureRecognizer(gesture)

    }
    
    @objc func clickImageView(){
        //Gallery açılcak
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true)
        
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        photoImageView.image = info[.originalImage] as? UIImage
        dismiss(animated: true)
    }

    @IBAction func uploadButton(_ sender: Any) {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let uuid = UUID().uuidString
        let mediaFolder = storageRef.child("media")
        if let data = photoImageView.image?.jpegData(compressionQuality: 0.5){
            let imageRef = mediaFolder.child("\(uuid).jpg")
            imageRef.putData(data, metadata: nil) { storagemetadata, error in
                if error != nil {
                    print(error?.localizedDescription)
                }else{
                    imageRef.downloadURL { url, error in
                        if error == nil {
                            let imageUrl = url?.absoluteString
                            print(imageUrl)
                        }
                    }
                }
               
            }
        }
    }
    
}
