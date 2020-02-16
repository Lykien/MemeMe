//
//  MemeCollectionViewController.swift
//  MemeMe
//
//  Created by Nils Riebeling on 15.09.19.
//  Copyright © 2019 Nils Riebeling. All rights reserved.
//

import UIKit





class MemeCollectionViewController: UICollectionViewController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    @IBOutlet weak var collectionViewFlow: UICollectionViewFlowLayout!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareCollectionFlowView(flowLaylout: self.collectionViewFlow)
     

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Reload the Meme data
        self.collectionView.reloadData()
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return appDelegate.memes.count
        
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "memeCollectionCell", for: indexPath) as! MemeCollectionViewCell
        cell.memeImage.image = appDelegate.memes[indexPath.row].memedImage
        
        return cell
    }
    
    // Prepare the view of the collection cell
    func prepareCollectionFlowView(flowLaylout: UICollectionViewFlowLayout){
        
        let space:CGFloat = 2.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        print(view.frame.size.width)
        
        flowLaylout.minimumInteritemSpacing = space
        flowLaylout.minimumLineSpacing = space
        flowLaylout.itemSize = CGSize(width: dimension, height: dimension)
        
        
        
    }
    
    // By selecting a item, the detail view will appear.
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailedController = self.storyboard?.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        detailedController.meme = appDelegate.memes[indexPath.row]
        self.navigationController?.pushViewController(detailedController, animated: true)
        
    }


}
