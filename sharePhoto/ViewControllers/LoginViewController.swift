//
//  ViewController.swift
//  sharePhoto
//
//  Created by Zülal Sarıoğlu on 14.03.2024.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func signInButton(_ sender: Any) {
        if emailTextField.text != "" && passwordTextField.text != ""{
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { authdataresult, error in
                if error != nil{
                    self.errorMessage(title: "Hata", message: error?.localizedDescription ?? "Kullanıcı yok")
                }else{
                    self.performSegue(withIdentifier: "toFeedVc", sender: nil)
                }
            }
        }else{
            errorMessage(title: "Hata", message: "Lütfen e-mail ve/veya password giriniz")
        }
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        if emailTextField.text != "" && passwordTextField.text != ""{
            //kullanıcı kayıt edicez
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { authdataresult, error in
                if error != nil {
                    self.errorMessage(title: "Hata", message: error?.localizedDescription ?? " Kullanıcı oluşturlamadı lütfen tekrar deneyin!")
                }else{
                    self.performSegue(withIdentifier: "toFeedVc", sender: nil)
                }
            }
        }
        else{
            errorMessage(title: "Hata", message: "Kullanıcı oluşturulamadı")
        }
        
    }
    
    
    func errorMessage(title: String , message: String ){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
}

