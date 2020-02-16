//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Nils Riebeling on 20.09.19.
//  Copyright © 2019 Nils Riebeling. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    @IBOutlet weak var memeImage: UIImageView!
    
    var meme: Meme!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.memeImage.image = self.meme.memedImage
    }
    
}
