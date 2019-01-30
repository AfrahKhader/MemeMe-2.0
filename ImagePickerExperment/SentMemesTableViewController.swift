//
//  SentMemesTableViewController.swift
//  ImagePickerExperment
//
//  Created by Afrah kheder on 25/12/2018.
//  Copyright © 2018 Udacity. All rights reserved.
//
import Foundation
import UIKit

class SentMemesTableViewController: UITableViewController {
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return memes.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SentMemesTableViewCell") as! SentMemesTableViewCell
        let meme = memes[(indexPath as NSIndexPath).row]
        
        // Set the name and image
        cell.tableImage?.image = meme.memedImage
        cell.label?.text = memes[indexPath.row].topText + "..." + memes[indexPath.row].bottomText
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailController = self.storyboard!.instantiateViewController(withIdentifier:
            "SentMemeDetailView") as! SentMemeDetailView
        detailController.meme = memes[(indexPath as NSIndexPath).row]
        self.navigationController!.pushViewController(detailController, animated: true)
    }
    

    
    
}
