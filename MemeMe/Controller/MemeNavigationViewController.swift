//
//  MemeNavigationViewController.swift
//  MemeMe
//
//  Created by Nils Riebeling on 15.09.19.
//  Copyright © 2019 Nils Riebeling. All rights reserved.
//

import UIKit

class MemeNavigationViewController: UINavigationController {
    @IBOutlet weak var memeMeNavigationBar: UINavigationBar!
   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        
    memeMeNavigationBar.topItem?.title = "Sent Memes"
    
      
    }
    

//    func add(){
//    
//    let addController = UIViewController()
//    present(addController, animated: true, completion: nil)
//    
//    }
    
    

}
