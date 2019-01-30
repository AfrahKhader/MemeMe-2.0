//
//  SentMemesCollectionViewController.swift
//  ImagePickerExperment
//
//  Created by Afrah kheder on 25/12/2018.
//  Copyright © 2018 Udacity. All rights reserved.
//
import Foundation
import UIKit

class SentMemesCollectionViewController: UICollectionViewController {
    
    
    @IBOutlet weak var flowlayout: UICollectionViewFlowLayout!
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView!.reloadData()
        self.tabBarController!.tabBar.isHidden = false
     }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.collectionView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let space:CGFloat = 3.0
        let cellWidth = (view.frame.size.width - (5 * space)) / 3.0
        let cellHeight = (view.frame.size.height - (5 * space)) / 3.0
        flowlayout.minimumInteritemSpacing = space
        flowlayout.itemSize = CGSize(width: cellWidth, height: cellHeight)
         self.collectionView.reloadData()
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
        
        // Grab the DetailVC from Storyboard
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "SentMemeDetailView") as! SentMemeDetailView
        
        //Populate view controller with data from the selected item
        detailController.meme = memes[(indexPath as NSIndexPath).row]
        
        // Present the view controller using navigation
        self.navigationController!.pushViewController(detailController, animated: true)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SentMemesCollectionViewCell", for: indexPath) as! SentMemesCollectionViewCell
        let meme = memes[(indexPath as NSIndexPath).row]
        // Set the image
        cell.memeImageView?.image = meme.memedImage
        return cell
    }
    
}
