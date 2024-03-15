//
//  FeedTableViewCell.swift
//  sharePhoto
//
//  Created by Zülal Sarıoğlu on 15.03.2024.
//

import UIKit

class FeedTableViewCell: UITableViewCell  {
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var lblYorum: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
