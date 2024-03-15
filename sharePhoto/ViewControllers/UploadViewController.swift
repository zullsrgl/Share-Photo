//
//  UploadViewController.swift
//  sharePhoto
//
//  Created by Zülal Sarıoğlu on 14.03.2024.
//

import UIKit
import FirebaseStorage
import FirebaseFirestore
import Firebase
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
        if let data = photoImageView.image?.jpegData(compressionQuality: 0.1){
            let imageRef = mediaFolder.child("\(uuid).jpg")
            imageRef.putData(data, metadata: nil) { storagemetadata, error in
                if error != nil {
                    self.alertMessage(title: "Hata!", subTitle: error?.localizedDescription ?? "Hata oluşty lütfen tekrar deneyin")
                }else{
                    imageRef.downloadURL { url, error in
                        if error == nil {
                            let imageUrl = url?.absoluteString
                    
                            let firestoreDatabase = Firestore.firestore()
                            let firestorePost = ["gorselurl" : imageUrl , "yorum": self.discriptionTextField.text! , "email" : Auth.auth().currentUser!.email! , "tarih" : FieldValue.serverTimestamp()]
                            firestoreDatabase.collection("Post").addDocument(data: firestorePost) { error in
                                if error != nil {
                                    self.alertMessage(title: "Hata", subTitle: error?.localizedDescription ?? "Hata")
                                }else{
                                    self.discriptionTextField.text = ""
                                    self.photoImageView.image = UIImage(systemName: "square.and.arrow.up.on.square")
                                    self.tabBarController?.selectedIndex = 0
                                }
                            }
                        }
                    }
                }
               
            }
        }
    }
    
    func alertMessage(title: String, subTitle: String) {
        let alert = UIAlertController(title: title, message: subTitle, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
}
