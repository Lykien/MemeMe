//
//  Meme.swift
//  MemeMe
//
//  Created by Nils Riebeling on 15.09.19.
//  Copyright © 2019 Nils Riebeling. All rights reserved.
//

import Foundation
import UIKit

struct Meme {
    var topText: String
    var bottomText: String
    let startImage: UIImage
    let memedImage: UIImage
    


init(topText: String, bottomText: String, startImage: UIImage, memedImage: UIImage){
    
    self.topText = topText as String
    self.bottomText = bottomText as String
    self.startImage = startImage as UIImage
    self.memedImage = memedImage as UIImage
    
}
}
