//
//  SettingsViewController.swift
//  sharePhoto
//
//  Created by Zülal Sarıoğlu on 14.03.2024.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func logoutButton(_ sender: Any) {
        performSegue(withIdentifier: "tologInVc", sender: nil)
    }
    
}
