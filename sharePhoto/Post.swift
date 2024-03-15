//
//  Post.swift
//  sharePhoto
//
//  Created by Zülal Sarıoğlu on 15.03.2024.
//

import Foundation

class Post {
    var email : String  = ""
    var yorum : String  = ""
    var resimUrl : String  = ""
    
    init(email: String, yorum: String, resimUrl: String) {
        self.email = email
        self.yorum = yorum
        self.resimUrl = resimUrl
    }
}
