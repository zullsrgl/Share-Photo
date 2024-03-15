//
//  FeedViewController.swift
//  sharePhoto
//
//  Created by Zülal Sarıoğlu on 14.03.2024.
//

import UIKit
import FirebaseFirestore
import SDWebImage
class FeedViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {


    @IBOutlet weak var tableView: UITableView!
   // var emailDizisi = [String]()
   // var gorselUrlDizi = [String]()
   // var yorumDizi = [String]()
    
    var postDizisi = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

   getData()
    }
    
    
    func getData(){
        let firestoreDatabase = Firestore.firestore()
        firestoreDatabase.collection("Post").order(by: "tarih", descending: true)
            .addSnapshotListener { snapshot, error in
            if error != nil{
                self.errorMessage(title: "Hata", subTitle: error?.localizedDescription ??  "Yüklenemedi tekrar deneyiniz")
            }else{
                if snapshot?.isEmpty != true && snapshot != nil {
                    self.postDizisi.removeAll(keepingCapacity: false)
                  
                    for document in snapshot!.documents {
                        if let gorselUrl = document.get("gorselurl") as? String{
                    
                            if let email = document.get("email") as? String {
                                
                                if let yorum = document.get("yorum") as? String {
                                    let post = Post(email: email, yorum: yorum, resimUrl: gorselUrl)
                                    self.postDizisi.append(post)
                                }
                            }
                        }
                        }
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func errorMessage(title: String, subTitle : String){
        let alert = UIAlertController(title: title, message: subTitle, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postDizisi.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedTableViewCell
        cell.lblEmail.text = postDizisi[indexPath.row].email
        cell.lblYorum.text = postDizisi[indexPath.row].yorum
        cell.postImageView.sd_setImage(with: URL(string: postDizisi[indexPath.row].resimUrl))
        return cell
    }
    

}
