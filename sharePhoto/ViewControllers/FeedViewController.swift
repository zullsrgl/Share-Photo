//
//  FeedViewController.swift
//  sharePhoto
//
//  Created by Zülal Sarıoğlu on 14.03.2024.
//

import UIKit

class FeedViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {


    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

   
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedTableViewCell
        cell.lblEmail.text = "zulal@gmail.com"
        cell.lblYorum.text = "Yükleeğ"
        cell.postImageView.image = UIImage(named: "pp")
        return cell
    }
    

}
