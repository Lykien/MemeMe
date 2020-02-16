//
//  MemeTableViewController.swift
//  MemeMe
//
//  Created by Nils Riebeling on 15.09.19.
//  Copyright © 2019 Nils Riebeling. All rights reserved.
//


import UIKit



class MemeTableViewController: UITableViewController {
    

   // Get the Meme object array from the AppDelegate
    var memes: [Meme]{
        let  object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Define the high of the table view row
        self.tableView.rowHeight = 100
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
       // Reload the Meme data
       self.tableView.reloadData()
    }
    

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return memes.count
    }
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeMeTableCell") as! MemeTableViewCell
    
        let meme = memes[indexPath.row]
        
        // Set the name and image
        cell.memeTextLable.text = meme.topText + " ... " + meme.bottomText
        cell.memeImageView.image = meme.memedImage
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        detailController.meme = self.memes[indexPath.row]
        self.navigationController!.pushViewController(detailController, animated: true)
    }

   

}
