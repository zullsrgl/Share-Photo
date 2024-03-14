//
//  SettingsViewController.swift
//  sharePhoto
//
//  Created by Zülal Sarıoğlu on 14.03.2024.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func logoutButton(_ sender: Any) {
        do {
           try Auth.auth().signOut()
        }catch{
            print("error: Çıkış yapılmadı")
        }
        performSegue(withIdentifier: "tologInVc", sender: nil)
    }
    
}
