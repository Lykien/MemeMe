//
//  MemeTableViewCell.swift
//  MemeMe
//
//  Created by Nils Riebeling on 16.10.19.
//  Copyright © 2019 Nils Riebeling. All rights reserved.
//

import UIKit

class MemeTableViewCell: UITableViewCell {

    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var memeTextLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        memeTextLable.textAlignment = .right
        // Configure the view for the selected state
    }

}
